class File
  def self.deep_write(path, content)
    FileUtils.mkdir_p File.dirname(path)
    File.write path, content
  end
end
