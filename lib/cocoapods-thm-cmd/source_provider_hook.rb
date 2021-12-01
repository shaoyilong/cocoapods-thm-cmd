require 'cocoapods-thm-cmd/native/sources_manager'
require 'cocoapods-thm-cmd/command/bin/repo/update'
require 'cocoapods/user_interface'

Pod::HooksManager.register('cocoapods-thm-cmd', :pre_install) do |_context, _|

    # pod bin repo update 更新二进制私有源
  # Pod::Command::Bin::Repo::Update.new(CLAide::ARGV.new([])).run

  # 有插件/本地库 且是dev环境下，默认进入源码白名单  过滤 archive命令
  if _context.podfile.plugins.keys.include?('cocoapods-thm-cmd')
    dependencies = _context.podfile.dependencies
    dependencies.each do |d|
      next unless d.respond_to?(:external_source) &&
                  d.external_source.is_a?(Hash) &&
                  !d.external_source[:path].nil?
      _context.podfile.set_use_source_pods d.name
    end
  end
end

Pod::HooksManager.register('cocoapods-thm-cmd', :source_provider) do |context, _|

  sources_manager = Pod::Config.instance.sources_manager
  podfile = Pod::Config.instance.podfile

  if podfile
    # 添加源码私有源 && 二进制私有源
    added_sources = [sources_manager.code_source]
    if podfile.use_binaries! || podfile.use_binaries_selector
      added_sources << sources_manager.binary_source
      added_sources.reverse!
    end
    added_sources.each { |source| context.add_source(source) }
  end
end
