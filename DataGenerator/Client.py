import requests

base_url = 'http://192.168.0.198:8080/'
create_user_url = base_url + 'user-service/users/register'
upload_video_url = base_url + 'video-service/videos/upload/'


class Client:

    @staticmethod
    def createUser(user):
        data = {
            'firstName': user.firstName,
            'lastName': user.lastName,
            'email': user.email,
            'password': user.password,
            'avatar': user.avatar,
            'preferences': user.preferences
        }

        response = requests.post(create_user_url, data=data)
        print(response.status_code)

    @staticmethod
    def uploadVideo(video, user_email):
        data = {
            'video': video.video_data,
            'filename': video.filename,
            'metadata': {
                'title': video.metadata.title,
                'description': video.metadata.description,
                'tags': video.metadata.tags,
                'studyPrograms': video.metadata.studyPrograms,
                'thumbnail': video.metadata.thumbnail,
                'language': video.metadata.language,
                'length': video.metadata.duration
            }
        }

        # headers={'Content-Type': 'multipart/form-data'}
        response = requests.post(upload_video_url + user_email, file=data)
        print(response.status_code)

