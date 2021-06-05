package googlebookswishlistproject

import grails.transaction.Transactional
//imports for the conection to the google api
import com.google.api.client.json.JsonFactory
import com.google.api.client.json.jackson2.JacksonFactory
import com.google.api.services.books.Books
import com.google.api.services.books.BooksRequestInitializer
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport

@Transactional
class GoogleBooksService {
    //get the books from the api
    private Books createBooks(){
        JsonFactory jsonFactory = JacksonFactory.getDefaultInstance()
        return new Books.Builder(GoogleNetHttpTransport.newTrustedTransport(), jsonFactory, null)
        .setGoogleClientRequestInitializer(new BooksRequestInitializer())
        .build()
    }

    //make a search by some text in title
    def search(String title){
        final Books books = createBooks()
        Books.Volumes.List list = books.volumes().list("intitle:" + title)
//        list.setKey("AIzaSyA_8rKZUFvMtF0RPq_Llc6SjWEulveKgVY")
        return list
    }
}
