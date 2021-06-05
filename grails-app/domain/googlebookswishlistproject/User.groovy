package googlebookswishlistproject

class User {
    String firstName
    String lastName

    //One user have many books (with the Google Books ids)
    static  hasMany = [books: Book]

}
