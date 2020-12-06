class Video:

    def __init__(self, video_data, filename, metadata):
        self.video_data = video_data
        self.filename = filename
        self.metadata = metadata


class Metadata:

    def __init__(self, title, description, study_program, tags, duration, language, thumbnail):
        self.title = title,
        self.description = description,
        self.studyProgram = study_program,
        self.tags = tags,
        self.duration = duration,
        self.language = language,
        self.thumbnail = thumbnail
