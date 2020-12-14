import random
from Client import Client

videos = [
    '5f99a524211302770012203e'
    '5fa28871527ac7147d6576fe'
    '5fa2c44d57098b4a996f2972'
    '5fa2d1473182f76147b634fb'
    '5fa2d2413182f76147b634fe'
    '5fccff02f1a70e1e98a03a03'
    '5fcd02cadf59547ebcb9052c'
    '5fd0b628b5b82e3c29b852e6'
    '5fd0b80387169022b39162d9'
    '5fd0b85678c72d0d4180db18'
    '5fd0b9563929fe443e78e808'
    '5fd0b9ba3929fe443e78e80e'
    '5fd0b9cf3929fe443e78e814'
    '5fd0b9e33929fe443e78e81a'
    '5fd0ba9a3929fe443e78e820'
    '5fd0bab43929fe443e78e826'
    '5fd0d8b067d0a77232ac9f06'
    '5fd0d8b167d0a77232ac9f0c'
    '5fd0d8b267d0a77232ac9f12'
    '5fd0d8b367d0a77232ac9f18'
]
users = [
    '5f70854d8dbffb0ae4482b70'
    '5f70be90e762992319b256ec'
    '5f70bfe0e762992319b256ed'
    '5f7d9987d63c01778de22b3e'
    '5f7dcbfe22d03071e3fc227a'
    '5f7dcc1622d03071e3fc227c'
    '5f7dcc2722d03071e3fc227e'
    '5f95c1aa670a736a85c64006'
    '5f95cf69670a736a85c64008'
    '5fa2932e23a8f45199a6a611'
    '5fd2365e267a441e9c56acae'
    '5fd248ca267a441e9c56acaf'
    '5fd64069ed7f42013c029657'
    '5fd640b5ed7f42013c029658'
    '5fd640f5ed7f42013c029659'
    '5fd647ad58737865f5c9daae'
    '5fd64b4758737865f5c9daaf'
]
search_terms = ['Java', 'OOP', 'Programming', 'Spring', 'WebServices', 'Mobile', 'Android', 'iOS', 'Cross-Platform',
                'Responsive Design', 'Cooling Systems', 'Fuel', 'Mechanics', 'Cars', 'Engines', 'Energy Systems',
                'Airbags', 'Materials', 'Dynamics', 'Design', 'Social Media', 'Marketing', 'Websites', 'Customers',
                'Online Marketing', 'Customer Behaviour', 'Building Design', 'Geomatics', 'Engineering', 'Environment',
                'Transportation', 'Water']


def choose_videos():
    chosen_videos = []
    for i in range(1, random.randint(0, 5)):
        chosen_videos.append(random.choice(videos))
    return chosen_videos


def choose_search_terms():
    chosen_search_terms = []
    for i in range(1, random.randint(0, 10)):
        chosen_search_terms.append(random.choice(search_terms))
    return chosen_search_terms


def generate_actions():
    for user in users:
        # Generate likes
        videos_to_like = choose_videos()
        Client.send_action('like', user, videos_to_like)

        # Generate dislikes
        videos_to_dislike = choose_videos()
        Client.send_action('dislike', user, videos_to_dislike)

        # Generate watch actions
        videos_to_watch = choose_videos()
        Client.send_action('watch', user, videos_to_watch)

        # Generate search actions
        search_terms_searched = choose_search_terms()
        Client.send_action('search', user, [], search_terms_searched)


generate_actions()
