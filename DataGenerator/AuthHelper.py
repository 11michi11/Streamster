import requests


class AuthHelper:

    def __init__(self, base_url):
        self.base_url = base_url
        self.token = ''

    def get_access_token(self):
        if self.token is not '':
            return self.token
        else:
            headers = {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Authorization': 'Basic bXktdHJ1c3RlZC1jbGllbnQ6c2VjcmV0',
                'Accept': '*/*',
            }
            form = {
                'grant_type': 'password',
                'username': 'matej@email.com',
                'password': 'password',
                'scope': ''
            }
            request_url = self.base_url + 'user-service/oauth/token'
            response = requests.post(request_url, data=form, headers=headers)
            if response.status_code is not 200:
                print(response.json())
            else:
                self.token = response.json()['access_token']
                return self.token
