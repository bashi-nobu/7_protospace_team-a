Structure of DataBase

## User
### association

```
has_many :prototypes, likes, comments
```

### table
- name
- email
- password
- avatar
- profile
- position
- occupation

## Prototype
### association

```
has_many :captured_images, comments, likes
has_many :tags, through: :tag_prototype
has_many :tag_prototype
belongs_to :user
```

### table
- title
- catch_copy
- concept
- user_id

## CapturedImage
### association

```
belongs_to :prototype
```

### table
- content
- status
- prototype_id


## Like
### association

```
belongs_to :user, :prototype
```

### table
- user_id
- prototype_id



## Comment
### association

```
belongs_to :user, :prototype
```

### table
- content
- user_id
- prototype_id

## tag
### association

```
has_many :tag_prototype
has_many :posts, through: :tag_prototype
```

### table
- tag_name
- prototype_id

## tag_prototype
### association

```
belongs_to :prototypes, :tags
```

### table
- tag_id
- prototype_id



# 7_protospace_team-a
