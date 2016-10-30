class Subject

  attr_accessor :name, :subject_url

  @@all = []

  def initialize
    self.all << self
  end

  def self.all
    @@all
  end

  def self.create_from_subjects(subjects_array)
    subjects_array.each do |subject_hash|
      new_subject = Subject.new(subject_hash)
      subject_hash.each do |key, value|
        new_subject.send("#{key}=", value)
      end
    end
  end

end
