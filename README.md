# README

### Ruby Exercise
#### Background Questions
1. Briefly explain the GIL assuming you were addressing a non-technical audience. What are the potential cost implications of the GIL for scaling a production application?

2. Also for a non-technical audience, explain how a background job queuing service could help when accessing external APIs.

#### Code Exercise
Using Ruby on Rails create a new application to fulfil the below requirements for a basic social networking site. The pages do not need to be beautiful or styled at all, though bonus points if they are.

1. I can create a "Member" by entering a name and their website address/URL.

2. The website URL should be shortened (e.g. using http://goo.gl) before being stored. The original should also be stored.

3. When a member is added, all the headings (h1-h3) on their website should be retrieved and stored.

4. Members can be friends with other members. Friendships are bi-directional (i.e. if A is friends with B, then B is friends with A).

5. On a member's profile page, it should list their name, website, and number of friends.

6. Add a search function to the homepage. The search input should match headings collected from member websites, and it should return a list of members and the relevant matched heading.

7. In order to help members figure out how to be introduced to other members add a similar search function to a member’s profile page. Perform this search in the context of the member (i.e. avoid returning the same member in results) and enhance the search results here to output the shortest path from the member to the search result members (e.g. if C is a result when searching from member A’s profile page, then A -> B -> C might be the shortest path).

You are encouraged to use gems and libraries as appropriate. We are looking for a simple, clean, elegant code, and appropriate testing.
Please put your source code in a public repo and provide us with the link to review. Create commits as appropriate as you work, avoiding a single commit when all work is completed. Answers to the background questions should be included as ANSWERS.txt in the root directory.

#### Built with

* Rails 5.2.3
* Ruby 2.4.1

#### Running specs

```sh
$ rspec
```

```sh
Friendship
  validations
    should validate that :member_id cannot be empty/falsy
    should validate that :friend_id cannot be empty/falsy
    should validate that :friend_id is case-sensitively unique within the scope of :member_id
  associations
    should belong to member required: true
    should belong to friend required: true
  friendship
    when the other member is not already a friend
      creates a mutual friendship
    when the other member is already a friend
      does not create friendship again
    when member and friend are same
      does not create friendship and throws error

Member
  validations
    should validate that :name cannot be empty/falsy
    should validate that :website_url cannot be empty/falsy
    should allow :website_url to be ‹"http://foo.com"›
  associations
    should have many friends
    should have many inverse_friends
  .search
    matching heading found
      returns members and the relevant matched headings
    no matching heading found
      returns empty
  #generate_url_key
    generates unique_id of specified length

CreateMember
  valid parameters
    creates a new member
  invalid parameters
    returns error message

ParseWebsiteContent
  parse member website
    retrives headings from website and store

Finished in 0.3669 seconds (files took 1.86 seconds to load)
19 examples, 0 failures
```
