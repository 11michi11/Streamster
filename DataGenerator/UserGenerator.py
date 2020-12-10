from os import listdir
from os.path import isfile, join
import base64
import random
from User import User, Preferences

image_path = '../videos/images/'
images = [image_file for image_file in listdir(image_path) if isfile(join(image_path, image_file))]


class UserGenerator:

    def generate_users(self, system_role):
        print('--------------- GENERATING USERS -----------------')

        user_list = []

        avatars = self.read_image_files()
        for avatar in avatars:
            first_name = self.generate_first_name()
            last_name = self.generate_last_name()
            email = self.generate_email()
            password = self.generate_password()
            preferences = self.generate_preferences()
            user = User(first_name, last_name, email, password, avatar, system_role, preferences)
            user_list.append(user)

        print('GENERATED ' + str(len(user_list)) + ' USERS')
        return user_list

    def generate_preferences(self):
        study_programs = []
        tags = []
        # generate preferred video length
        video_min_length = self.generate_preferred_min_length()
        video_max_length = self.generate_preferred_max_length()

        # generate preferred study programs
        random_size = random.randint(1, 3)
        i = 0
        while i < random_size:
            i += 1
            preferred_study_program = self.generate_preferred_study_program()
            if preferred_study_program not in study_programs:
                study_programs.append(preferred_study_program)

        # generate preferred tags
        random_size = random.randint(1, 10)
        i = 0
        while i < random_size:
            i += 1
            preferred_tag = self.generate_preferred_tags()
            if preferred_tag not in tags:
                tags.append(preferred_tag)

        preferences = Preferences(study_programs, tags, video_min_length, video_max_length)
        return preferences

    @staticmethod
    def read_image_files():
        encoded_images = []

        for image in images:
            with open(image_path + image, "rb") as file:
                encoded_string = base64.b64encode(file.read())
                encoded_images.append(encoded_string)
        return encoded_images

    @staticmethod
    def generate_first_name():
        names = ['Adriana', 'Leve', 'Robin', 'Tereza', 'Peter', 'Ondrej', 'Jano', 'Jarek', 'Octavia', 'Rusell',
                 'Michaela',
                 'Michal', 'Matej', 'Janosik', 'Harry', 'Ursula', 'Beata', 'Jarek', 'Anka', 'Jaroslav', 'Tom', 'Livia',
                 'Niko']

        return random.choice(names)

    @staticmethod
    def generate_last_name():
        surnames = ['Spencer', 'Williams', 'Erikson', 'Neal', 'Velasquez', 'Christensen', 'Howard', 'Holland', 'Ray',
                    'Duncan', 'Riley', 'Hughes', 'Anderson', 'Martin', 'Stephenson', 'Moran', 'Munoz', 'Jenkins']

        return random.choice(surnames)

    @staticmethod
    def generate_email():
        names = ['Adriana', 'Leve', 'Robin', 'Tereza', 'Peter', 'Ondrej', 'Jano', 'Jarek', 'Octavia', 'Rusell',
                 'Michaela',
                 'Michal', 'Matej', 'Janosik', 'Harry', 'Ursula', 'Beata', 'Jarek', 'Anka', 'Jaroslav', 'Tom', 'Livia',
                 'Niko', 'Spencer', 'Williams', 'Erikson', 'Neal', 'Velasquez', 'Christensen', 'Howard', 'Holland', 'Ray',
                 'Duncan', 'Riley', 'Hughes', 'Anderson', 'Martin', 'Stephenson', 'Moran', 'Munoz', 'Jenkins']
        random_number = random.randint(0, 1000)
        emails = ['@gmail.com', '@hotmail.com', '@zoznam.sk', '@yahoo.com', '@page.com']

        random_name = random.choice(names)
        random_email = random.choice(emails)

        return random_name + str(random_number) + random_email

    @staticmethod
    def generate_password():
        passwords = 'Password1234'

        return passwords

    @staticmethod
    def generate_preferred_study_program():
        study_programs = ['ICT', 'GBE', 'ME', 'MM', 'VCE']

        return random.choice(study_programs)

    @staticmethod
    def generate_preferred_tags():
        tags = ['Java', 'OOP', 'Programming', 'Spring', 'WebServices', 'Mobile', 'Android', 'iOS', 'Cross-Platform',
                'Responsive Design', 'Cooling Systems', 'Fuel', 'Mechanics', 'Cars', 'Engines', 'Energy Systems',
                'Airbags', 'Materials', 'Dynamics', 'Design', 'Social Media', 'Marketing', 'Websites', 'Customers',
                'Online Marketing', 'Customer Behaviour', 'Building Design', 'Geomatics', 'Engineering', 'Environment',
                'Transportation', 'Water']

        return random.choice(tags)

    @staticmethod
    def generate_preferred_max_length():
        random_length = random.randint(300, 7200)
        return random_length

    @staticmethod
    def generate_preferred_min_length():
        random_length = random.randint(60, 240)
        return random_length




