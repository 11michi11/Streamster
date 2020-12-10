class User:

    def __init__(self, first_name, last_name, email, password, avatar, system_role, preferences):
        self.firstName = first_name,
        self.lastName = last_name,
        self.email = email,
        self.password = password,
        self.avatar = avatar,
        self.systemRole = system_role,
        self.preferences = preferences


class Preferences:

    def __init__(self, study_program, tags, min_length, max_length):
        self.studyProgram = study_program,
        self.tags = tags,
        self.minLength = min_length,
        self.maxLength = max_length
