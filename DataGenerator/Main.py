from Client import Client
from UserGenerator import UserGenerator
from VideoGenerator import VideoGenerator
from Video import Video

system_role_teacher = 'TEACHER'
system_role_student = 'STUDENT'

# create generators
generator = VideoGenerator()
user_generator = UserGenerator()

# generate metadata
videos_encoded = generator.read_video_files()
filename = 'video.mp4'
videoList = []
generated_metadata_ict = generator.generate_metadata_ict()
generated_metadata_marketing = generator.generate_metadata_marketing()
generated_metadata_mechanics = generator.generate_metadata_mechanics()
generated_metadata_civil = generator.generate_metadata_civil()

# generate video for each metadata
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

users = user_generator.generate_users(system_role_teacher)
#
# for user in users:
# Client.createUser(users[0])

for video in videoList:
    Client.uploadVideo(video, 'matej@email.com')


