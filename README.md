# Twitter Application

#### The API end-points of the application

For user authentication feature (Section 1):
| Method | End-point | Description |
| ------ | ------ | ------ |
| POST | localhost:3000/api/v1/auth | Create new user |
| POST | localhost:3000/api/v1/auth/sign_in | Login user |

For Create, Read, Update and Delete tweet feature (Section 2):
| Method | End-point | Description |
| ------ | ------ | ------ |
| POST | localhost:3000/api/v1/tweets | Create new tweet |
| GET | localhost:3000/api/v1/tweets | List user's tweets |
| PUT/PATCH | localhost:3000/api/v1/tweets/:id | Update tweet |
| POST | localhost:3000/api/v1/tweets/:id | Show tweet |
| DELETE | localhost:3000/api/v1/tweets/:id | Delete tweet |

For Chat with other users feature (Section 2):
| Method | End-point | Description |
| ------ | ------ | ------ |
| POST | localhost:3000/api/v1/conversations | Create new Conversation |
| POST | localhost:3000/api/v1/conversations/:conversation_id/messages | Create message of a specific conversation |
| GET | localhost:3000/api/v1/conversations/:conversation_id/messages | List messages of a specifc conversation |

Like/unlike a tweet feature (Section 3):
| Method | End-point | Description |
| ------ | ------ | ------ |
| POST | localhost:3000/api/v1/tweets/:tweet_id/likes | Like a tweet |
| DELETE | localhost:3000/api/v1/tweets/:tweet_id/likes/:id | Unlike a tweet |

Retweet feature (Section 3):
| Method | End-point | Description |
| ------ | ------ | ------ |
| POST | localhost:3000/api/v1/tweets/:tweet_id/retweets | Create retweet |
| DELETE | localhost:3000/api/v1/tweets/:tweet_id/retweets/:id | Delete retweet |
