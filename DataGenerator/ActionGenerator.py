import random
from Client import Client

videos = [
    '5fd89ba230f6ba1f0890808f',
    '5fd89ba330f6ba1f08908095',
    '5fd89ba530f6ba1f0890809b',
    '5fd89ba630f6ba1f089080a1',
    '5fd89ba730f6ba1f089080a7',
    '5fd89ba830f6ba1f089080ad',
    '5fd89ba930f6ba1f089080b3',
    '5fd89ba930f6ba1f089080b9',
    '5fd89bab30f6ba1f089080bf',
    '5fd89bac30f6ba1f089080c5',
    '5fd89bac30f6ba1f089080cb',
    '5fd89bad30f6ba1f089080d1',
    '5fd89bae30f6ba1f089080d7',
    '5fd89baf30f6ba1f089080dd',
    '5fd89bb030f6ba1f089080e3',
    '5fd89bb130f6ba1f089080e9',
    '5fd89bb230f6ba1f089080ef',
    '5fd89bb330f6ba1f089080f5',
    '5fd89bb430f6ba1f089080fb',
    '5fd89bb530f6ba1f08908101',
    '5fd89bb630f6ba1f08908107',
    '5fd89bb730f6ba1f0890810d',
    '5fd89bb830f6ba1f08908113',
    '5fd89bb930f6ba1f08908119',
    '5fd89bba30f6ba1f0890811f',
    '5fd89bbb30f6ba1f08908125',
    '5fd89bbc30f6ba1f0890812b',
    '5fd89bbd30f6ba1f08908131',
    '5fd89bbe30f6ba1f08908137',
    '5fd89bbf30f6ba1f0890813d',
    '5fd89bc230f6ba1f08908164',
    '5fd89bc630f6ba1f0890818b',
    '5fd89bca30f6ba1f089081b2',
    '5fd89bce30f6ba1f089081d9',
    '5fd89bd330f6ba1f08908200',
    '5fd89bd630f6ba1f08908227',
    '5fd89bda30f6ba1f0890824e',
    '5fd89bde30f6ba1f08908275',
    '5fd89bdf30f6ba1f0890827b',
    '5fd89be030f6ba1f08908281',
    '5fd89be130f6ba1f08908287',
    '5fd89be230f6ba1f0890828d',
    '5fd89be330f6ba1f08908293',
    '5fd89c1a30f6ba1f08908299',
    '5fd89c2030f6ba1f0890829f',
    '5fd89c2b30f6ba1f089082a5',
    '5fd89c3730f6ba1f089082ab',
    '5fd89c3e30f6ba1f089082b1',
    '5fd89c4530f6ba1f089082b7',
    '5fd89c4f30f6ba1f089082bd',
    '5fd89c5430f6ba1f089082c3',
    '5fd89c8d30f6ba1f089082ea',
    '5fd89cc230f6ba1f08908311',
    '5fd89d1f30f6ba1f08908338',
    '5fd89d7430f6ba1f0890835f',
    '5fd89dac30f6ba1f08908386',
    '5fd89de530f6ba1f089083ad',
    '5fd89e2a30f6ba1f089083d4',
    '5fd89e6130f6ba1f089083fb',
    '5fd89eb530f6ba1f08908422',
    '5fd89f1630f6ba1f08908449',
    '5fd89f5c30f6ba1f08908470',
    '5fd89fad30f6ba1f08908497'
]
users = [
    "matej@email.com",
    "Jaroslav752@yahoo.com",
    "Jano949@zoznam.sk",
    "Martin310@zoznam.sk",
    "Tereza424@hotmail.com",
    "Adriana979@yahoo.com",
    "Rusell825@zoznam.sk",
    "Anka882@gmail.com",
    "Ondrej72@hotmail.com",
    "Velasquez793@gmail.com",
    "Beata918@hotmail.com",
    "Riley458@zoznam.sk",
    "Peter758@gmail.com",
    "Duncan927@page.com",
    "Leve934@gmail.com",
    "Tereza883@page.com",
    "Michaela535@yahoo.com",
    "Michal892@gmail.com",
    "Martin661@hotmail.com",
    "Moran219@hotmail.com",
    "Harry407@page.com",
    "Jarek772@zoznam.sk",
    "Stephenson841@yahoo.com",
    "Riley532@gmail.com",
    "Janosik800@yahoo.com",
    "Duncan248@page.com",
    "Stephenson84@hotmail.com",
    "Moran786@hotmail.com",
    "Jaroslav774@yahoo.com",
    "Riley4@hotmail.com",
    "Janosik602@hotmail.com",
    "Jenkins598@zoznam.sk",
    "Ursula967@gmail.com",
    "Matej94@gmail.com",
    "Jano111@yahoo.com",
    "Matej498@page.com",
    "Neal679@page.com",
    "Hughes328@hotmail.com",
    "Holland312@yahoo.com",
    "Jaroslav235@zoznam.sk",
    "Adriana318@gmail.com",
    "Ursula267@zoznam.sk",
    "Jarek148@zoznam.sk",
    "Anderson879@page.com",
    "Rusell601@page.com",
    "Duncan943@gmail.com",
    "Rusell854@hotmail.com",
    "Tereza730@page.com",
    "Ondrej327@page.com",
    "Niko865@gmail.com",
    "Jarek845@hotmail.com",
    "Peter407@page.com",
    "Adriana315@zoznam.sk",
    "Peter470@page.com",
    "Ondrej635@page.com",
    "Duncan66@zoznam.sk",
    "Niko491@yahoo.com",
    "Jano772@hotmail.com",
    "Jenkins38@zoznam.sk",
    "Howard376@page.com",
    "Janosik143@page.com",
    "Neal351@page.com",
    "Riley513@hotmail.com",
    "Jenkins885@zoznam.sk",
    "Hughes990@gmail.com"
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

        print("generated actions for user " + str(user))


generate_actions()
