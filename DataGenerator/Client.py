import json
import requests

from AuthHelper import AuthHelper

base_url = 'http://localhost:8080/'
create_user_url = base_url + 'user-service/users/registerWithPreferences'
upload_video_url = base_url + 'video-service/videos/testUpload'
watch_video_url = base_url + 'video-service/videos/'
file_path = 'data.txt'
video_path = '../videos/'
auth_helper = AuthHelper(base_url)


class Client:

    @staticmethod
    def create_user(user):
        data = {
            'firstName': user.firstName[0],
            'lastName': user.lastName[0],
            'email': user.email[0],
            'password': user.password[0],
            'avatar': user.avatar[0],
            'systemRole': user.systemRole[0],
            'preferences': {
                'studyPrograms': user.preferences.studyProgram[0],
                'tags': user.preferences.tags[0],
                'minLength': user.preferences.minLength[0],
                'maxLength': user.preferences.maxLength,
            }
        }

        # f = open(file_path, "a")
        # f.write(str(data))
        # f.close()

        token = auth_helper.get_access_token()
        headers = {
            'Content-Type': 'application/json',
            'Authorization': f'Bearer {token}'
        }
        response = requests.post(create_user_url, data=json.dumps(data), headers=headers)
        if response.status_code != 201:
            print(response.status_code)
            print(response.json())
        else:
            print(f'successfully user {user.email[0]}')

    @staticmethod
    def upload_video(video, user_email):
        metadata = {
            'title': video.metadata.title[0],
            'description': video.metadata.description[0],
            'tags': video.metadata.tags[0],
            'studyPrograms': video.metadata.studyProgram[0],
            'thumbnail': video.metadata.thumbnail,
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

        # response = requests.post(upload_video_url + '/' + user_email, data=body, headers=headers)
        # if response.status_code is not 201:
        #     print(response.status_code)
        #     print(response.json())
        # else:
        #     print(f'successfully uploaded video {video.metadata.title} for user {user_email}')

    @staticmethod
    def send_action(action, user, videos=[], search_terms=[]):
        token = auth_helper.get_access_token()
        headers = {
            'Authorization': f'Bearer {token}'
        }

        if action == 'like':
            for video in videos:
                requests.post(base_url + f'video-service/videos/{video}/like/{user}', headers=headers)
        elif action == 'dislike':
            for video in videos:
                requests.post(base_url + f'video-service/videos/{video}/dislike/{user}', headers=headers)
        elif action == 'watch':
            for video in videos:
                requests.post(base_url + f'video-service/videos/{video}/dislike/{user}', headers=headers)
        elif action == 'search':
            for search_term in search_terms:
                requests.post(base_url + f'search-service/testSearch/{user}?searchTerm={search_term}', headers=headers)
