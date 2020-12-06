class User:

    def __init__(self, first_name, last_name, email, password, avatar, preferences):
        self.firstName = first_name,
        self.lastName = last_name,
        self.email = email,
        self.password = password,
        self.avatar = avatar,
        self.preferences = preferences


class Preferences:

    def __init__(self, study_program, tags, length):
        self.studyProgram = study_program,
        self.tags = tags,
        self.length = length
