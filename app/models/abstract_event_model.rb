class AbstractEventModel < AbstractModel
  self.abstract_class = true

  def self.abstract_bootloader
    return if self.abstract_class
    super
  end
end
