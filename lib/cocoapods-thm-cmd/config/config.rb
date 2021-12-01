
module THMCmd
  class Config

    def code_repo_url
      load_config_hash['code_repo_url']
    end

    def binary_repo_url
      load_config_hash['binary_repo_url']
    end

    def binary_download_url(moduleName, moduleVersion)
      local_config = load_config_hash
      local_config['binary_download_url'].sub('%s', moduleName+'.framework_'+moduleVersion)
    end

    def load_config_hash
      {
        'code_repo_url' => 'https://github.com/CocoaPods/Specs.git',
        'binary_repo_url' => 'https://github.com/shaoyilong/example_spec_bin_dev.git',
        # 二进制下载地址，内部会依次传入组件名称与版本，替换字符串中的 %s
        'binary_download_url' => 'https://github.com/shaoyilong/static_framework_zips/%s.zip',
        # 'binary_type' => { description: '二进制打包类型', default: 'framework', selection: %w[framework library] },
        'download_file_type' => { description: '下载二进制文件类型', default: 'zip', selection: %w[zip tgz tar tbz txz dmg] }
      }
    end
  end

  def self.config
    @config ||= Config.new
  end

end