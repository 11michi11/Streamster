from os import listdir
from os.path import isfile, join
from moviepy.editor import VideoFileClip
import base64
import random
from Video import Video, Metadata
from UserGenerator import UserGenerator

video_path = '../videos/'
image_path = '../videos/images/'
videos = [video_file for video_file in listdir(video_path) if isfile(join(video_path, video_file))]

# study programs
software_engineering = 'ICT'
global_business_eng = 'GBE'
civil_eng = 'CE'
mechanical_eng = 'ME'
marketing = 'MM'
value_chain = 'VCE'


class VideoGenerator:

    @staticmethod
    def read_video_files():
        print('----------------- READING VIDEOS -----------------')
        print(videos)
        video_list = []

        for video in videos:
            with open(video_path + video, "rb") as file:
                data = file.read()
                video_list.append(data)
                # filename = video
                # title = filename[:-4] # remove .mp4 from title
                # clip = VideoFileClip(path + video)
                # duration = clip.duration
        return video_list

    def generate_metadata_ict(self):
        print('------------ GENERATING METADATA -----------------')

        metadata_list = []
        thumbnail = self.get_thumbnail()
        language = self.generate_language()
        description = self.description_ict()

        ict_java_titles = self.title_ict_java()
        ict_mobile_titles = self.title_ict_mobile()
        ict_titles = self.title_ict()

        for java_title in ict_java_titles:

            tags = []
            i = 0
            while i < 4:
                i += 1
                tag = self.generate_tag_ict_java()
                if tag not in tags:
                    tags.append(tag)

            metadata = Metadata(java_title, description, [software_engineering, global_business_eng],
                                tags, self.generate_duration(), language, thumbnail)
            metadata_list.append(metadata)

        for mobile_title in ict_mobile_titles:

            tags = []
            i = 0
            while i < 4:
                i += 1
                tag = self.generate_tag_ict_mobile()
                if tag not in tags:
                    tags.append(tag)

            metadata = Metadata(mobile_title, description, [software_engineering], tags,
                                self.generate_duration(), language, thumbnail)
            metadata_list.append(metadata)

        for ict_title in ict_titles:

            tags = []
            i = 0
            while i < 5:
                i += 1
                tag = self.generate_tag_ict_mobile()
                if tag not in tags:
                    tags.append(tag)

            metadata = Metadata(ict_title, description, [software_engineering, global_business_eng], tags,
                                self.generate_duration(), language, thumbnail)
            metadata_list.append(metadata)

        print('----------- METADATA FOR ICT GENERATED -----------')
        return metadata_list

    def generate_metadata_marketing(self):
        print('------------ GENERATING METADATA -----------------')

        metadata_list = []
        thumbnail = self.get_thumbnail()
        language = self.generate_language()
        description = self.description_marketing()
        marketing_titles = self.title_marketing()

        for marketing_title in marketing_titles:

            tags = []
            i = 0
            while i < 4:
                i += 1
                tag = self.generate_tag_marketing()
                if tag not in tags:
                    tags.append(tag)

            metadata = Metadata(marketing_title, description, [marketing, global_business_eng, value_chain],
                                tags, self.generate_duration(), language, thumbnail)
            metadata_list.append(metadata)

        print('-------- METADATA FOR MARKETING GENERATED --------')
        return metadata_list

    def generate_metadata_mechanics(self):
        print('------------ GENERATING METADATA -----------------')

        metadata_list = []
        thumbnail = self.get_thumbnail()
        language = self.generate_language()
        description = self.description_mechanics()
        mechanics_titles = self.title_mechanics()

        for mechanic_title in mechanics_titles:

            tags = []
            i = 0
            while i < 4:
                i += 1
                tag = self.generate_tag_mechanics()
                if tag not in tags:
                    tags.append(tag)

            metadata = Metadata(mechanic_title, description, mechanical_eng,
                                tags, self.generate_duration(), language, thumbnail)
            metadata_list.append(metadata)

        print('-------- METADATA FOR MECHANICS GENERATED --------')
        return metadata_list

    def generate_metadata_civil(self):
        print('------------ GENERATING METADATA -----------------')

        metadata_list = []
        thumbnail = self.get_thumbnail()
        language = self.generate_language()
        description = self.description_civil()
        civil_titles = self.title_mechanics()

        for civil_title in civil_titles:

            tags = []
            i = 0
            while i < 4:
                i += 1
                tag = self.generate_tag_civil()
                if tag not in tags:
                    tags.append(tag)

            metadata = Metadata(civil_title, description, [civil_eng, value_chain],
                                tags, self.generate_duration(), language, thumbnail)
            metadata_list.append(metadata)

        print('-------- METADATA FOR MECHANICS GENERATED --------')
        return metadata_list

    @staticmethod
    def get_thumbnail():
        with open(image_path + 'thumbnail.jpg', "rb") as file:
            thumbnail = base64.b64encode(file.read())

        return thumbnail

    @staticmethod
    def generate_language():
        languages = ['Danish', 'English']
        return random.choice(languages)

    @staticmethod
    def generate_duration():
        random_duration = random.randint(60, 7200)
        return random_duration

    @staticmethod
    def title_ict_java():
        titles = ['Java Object Programming', 'Java for Android', 'Java Spring Boot', 'Java 2020 What is new',
                  'Java Master clean code', 'How to master Java', 'Java Security API', 'Java for beginners',
                  'Java for advance programmers', 'How to learn programming in Java', 'Java RMI', 'Java Threads',
                  'Java Patterns', 'JavaFX', 'Solid principles with Java', 'Java Swing', 'How was Java made',
                  'Creator of Java', 'Web Services in Java', 'SOAP with Java', 'REST with Java']
        return titles

    @staticmethod
    def title_ict_mobile():
        titles = ['Mobile dev 2020', 'What is new in Flutter', 'Flutter cross-platform dev', 'Android development',
                  'Kotlin for Android', 'Why is Flutter better than React Native', 'Why not to use React Native',
                  'Dart for beginners', 'Flutter Widgets Tutorial', 'How to make responsive design in Flutter',
                  'Responsive Android', 'Type of layout for Android', 'Android Jetpack',
                  'Future of Android development', 'Will cross-platform development take over native applications?']
        return titles

    @staticmethod
    def title_ict():
        titles = ['Uncle Bob - Clean Code', 'My Programming Journey', 'Fingerprint-based ATM system',
                  'Image encryption using AES algorithm', 'Credit card fraud detection', 'AI shopping system',
                  'Camera motion sensor system', 'Bug tracker', 'Smart health prediction system',
                  'Software piracy protection systems', 'Bitcoin and Cryptocurrency', 'Algorythm and Data Structures',
                  'EMBEDDED Systems 2020', 'Micro-Services architecture', 'Android task monitoring',
                  'Reverse engineering - What is important to know', 'Basic network security', 'Encryption and Security']
        return titles

    @staticmethod
    def title_mechanics():
        titles = ['How to build your race car', 'Math for mechanical engineers', 'Aerodynamics and Fluid Mechanics',
                  'Biomechanics', 'Combustion and Energy Systems', 'Design and Manufacturing', 'Dynamics and Control',
                  'Materials and Structures', 'Vibrations, Acoustics and Fluid-Structure Interactions',
                  '3 Axis Digital Accelerometer', '3D Solar cells4 Stroke Engines', '4-Wheel Independent Suspension',
                  '6 stroke engineAblative Materials', 'Abrasive Blast Cleaning', 'Abrasive Etching', 'Accelerometer',
                  'Acoustic finite elements', 'Advanced Ferryboat Technologies',
                  'Adaptive compensation of DTV induced brake judder', 'Adaptive Cruise Control',
                  'Adaptive Light pattern', 'Advanced Airbags for more protection',
                  'Advanced Battery and Fuel Cell Development for Electric Vehicles', 'Advanced Composite Materials',
                  'Advanced Cooling Systems', 'Advanced Energy Conversion Systems']

        return titles

    @staticmethod
    def title_marketing():
        titles = ['Importance of Consumer Buying Behaviour',
                  'Impact of Brand Positioning on Consumer Learning and Brand Loyalty',
                  'Social Media Marketing', 'Consumer behaviour on Airtel', 'A Study on Online Marketing',
                  'Study of consumer behavior in Automotive industry',
                  'Marketing through social media and bookmarking sites',
                  'Effectiveness of Online Classifieds Website',
                  'Emergence of E-Commerce - A brief history - Indian scenario',
                  'A study on Future of BPO', 'A competitive analysis and study in Indian Telecom Sector',
                  'A study on customer satisfaction towards Ventura Pumps',
                  'Radio as a promotional tool an exploratory study',
                  'Effectiveness of Retailing Mix in Big Bazaar', 'A project report on Apollo tyres brand image']

        return titles

    @staticmethod
    def title_civil():
        titles = ['Building Design and Drawing', 'Building Technology',
                  'Construction Management and Quantity Surveying',
                  'Economics and Management', 'Environmental Engineering', 'Environmental Studies in Civil Engineering',
                  'Functional Design of Buildings', 'Geomatics', 'Geosciences', 'Geotechnology', 'Mechanics of Fluids',
                  'Mechanics of Solids', 'Open Channel Hydraulics and Hydrology', 'Structural Analysis',
                  'Structural Design',
                  'Surveying', 'Transportation Engineering', 'Water Resources Engineering']

        return titles

    @staticmethod
    def generate_tag_ict_java():
        tags = ['Java', 'OOP', 'Programming', 'Spring', 'WebServices']
        return random.choice(tags)

    @staticmethod
    def generate_tag_ict_mobile():
        tags = ['Mobile', 'Android', 'iOS', 'Cross-Platform', 'Responsive Design', 'Cooling Systems', 'Fuel']
        return random.choice(tags)

    @staticmethod
    def generate_tag_mechanics():
        tags = ['Mechanics', 'Cars', 'Engines', 'Energy Systems', 'Airbags', 'Materials', 'Dynamics', 'Design']
        return random.choice(tags)

    @staticmethod
    def generate_tag_marketing():
        tags = ['Social Media', 'Marketing', 'Websites', 'Customers', 'Online Marketing', 'Customer Behaviour']
        return random.choice(tags)

    @staticmethod
    def generate_tag_civil():
        tags = ['Building Design', 'Geomatics', 'Engineering', 'Environment', 'Transportation', 'Water']
        return random.choice(tags)

    @staticmethod
    def generate_description_ict():
        descriptions = ['Programming principles and design for students']
        return random.choice(descriptions)

    @staticmethod
    def description_ict():
        description = 'Programming is the process of creating a set of instructions that tell a computer how to ' \
                      'perform a task. Programming can be done using a variety of computer programming languages, ' \
                      'such as JavaScript, Python, and C++. '
        return description

    @staticmethod
    def description_mechanics():
        description = ['Mechanical engineering is an engineering branch that combines engineering physics and '
                       'mathematics principles with materials science to design, analyze, manufacture, and maintain '
                       'mechanical systems. ... It is the branch of engineering that involves the design, production, '
                       'and operation of machinery.']
        return description

    @staticmethod
    def description_marketing():
        description = ['Marketing refers to activities a company undertakes to promote the buying or selling of a '
                       'product or service. Marketing includes advertising, selling, and delivering products to '
                       'consumers or other businesses. Some marketing is done by affiliates on behalf of a company.']
        return description

    @staticmethod
    def description_civil():
        description = ['Civil engineers design major transportation projects. Civil engineers conceive, design, '
                       'build, supervise, operate, construct and maintain infrastructure projects and systems in the '
                       'public and private sector, including roads, buildings, airports, tunnels, dams, bridges, '
                       'and systems for water supply and sewage treatment.']
        return description


# tests
generator = VideoGenerator()

videos_encoded = generator.read_video_files()
filename = 'video.mp4'
videoList = []
generated_metadata_ict = generator.generate_metadata_ict()
generated_metadata_marketing = generator.generate_metadata_marketing()
generated_metadata_mechanics = generator.generate_metadata_mechanics()
generated_metadata_civil = generator.generate_metadata_civil()

for metadata in generated_metadata_ict:
    video = Video(videos_encoded[0], filename, metadata)
    videoList.append(video)

for metadata in generated_metadata_marketing:
    video = Video(videos_encoded[1], filename, metadata)
    videoList.append(video)

for metadata in generated_metadata_mechanics:
    video = Video(videos_encoded[0], filename, metadata)
    videoList.append(video)

for metadata in generated_metadata_civil:
    video = Video(videos_encoded[1], filename, metadata)
    videoList.append(video)

print('GENERATED ' + str(len(videoList)) + ' VIDEOS')

user_generator = UserGenerator()
users = user_generator.generate_users()

