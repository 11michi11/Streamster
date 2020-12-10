import json
import base64
import requests

from AuthHelper import AuthHelper

base_url = 'http://localhost:8080/'
create_user_url = base_url + 'user-service/users/registerWithPreferences'
upload_video_url = base_url + 'video-service/videos/testUpload'
file_path = 'data.txt'
video_path = '../videos/'
auth_helper = AuthHelper(base_url)


class Client:

    @staticmethod
    def createUser(user):
        data = {
            'firstName': user.firstName[0],
            'lastName': user.lastName[0],
            'email': user.email[0],
            'password': user.password[0],
            'avatar': base64.b64encode(user.avatar[0]).decode(),
            'systemRole': user.systemRole[0],
            'preferences': {
                'studyPrograms': user.preferences.studyProgram[0],
                'tags': user.preferences.tags[0],
                'minLength': user.preferences.minLength[0],
                'maxLength': user.preferences.maxLength,
            }
        }
        print(data['preferences'])

        f = open(file_path, "a")
        f.write(str(data))
        f.close()

        token = auth_helper.get_access_token()
        headers = {
            'Content-Type': 'application/json',
            'Authorization': f'Bearer {token}'
        }
        response = requests.post(create_user_url, data=json.dumps(data), headers=headers)
        if response.status_code is not 201:
            print(response.status_code)
            print(response.json())
        else:
            print(f'successfully user {user.email[0]}')

    @staticmethod
    def uploadVideo(video, user_email):
        metadata = {
            'title': video.metadata.title[0],
            'description': video.metadata.description[0],
            'tags': video.metadata.tags[0],
            'studyPrograms': video.metadata.studyProgram[0],
            'thumbnail': base64.b64encode(video.metadata.thumbnail).decode(),
            'language': video.metadata.language[0],
            'length': video.metadata.duration[0],
        }

        files = {
            'video': ('video', video.video_data, 'multipart/form-data'),
            'metadata': ('metadata', json.dumps(metadata).encode('utf-8'), 'application/json')
        }

        token = auth_helper.get_access_token()
        body, content_type = requests.models.RequestEncodingMixin._encode_files(files, {})
        headers = {
            'Content-Type': content_type,
            'Authorization': f'Bearer {token}'
        }

        response = requests.post(upload_video_url + '/' + user_email, data=body, headers=headers)
        if response.status_code is not 201:
            print(response.status_code)
            print(response.json())
        else:
            print(f'successfully uploaded video {video.metadata.title} for user {user_email}')
