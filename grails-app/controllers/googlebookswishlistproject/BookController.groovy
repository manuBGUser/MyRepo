package googlebookswishlistproject

import com.google.api.services.books.model.Volumes
import static org.springframework.http.HttpStatus.*
import com.google.api.services.books.Books

import grails.transaction.Transactional

@Transactional(readOnly = true)
class BookController {
    def googleBooksService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        Books.Volumes.List books = googleBooksService.search(" ")
        Volumes volumes = books.execute()
        [view: 'index', list: volumes.getItems(), user: params.userId]//falta el count que no funcionaba
    }

    def search(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if (params.query != null && params.query != " ") {
            Books.Volumes.List books = googleBooksService.search(params.query)
            Volumes volumes = books.execute()
            render(view: "index", model: [ list: volumes.getItems(), query: params.query, user: params.user])//falta el count que no funcionaba
        }
        else{
            Books.Volumes.List books = googleBooksService.search(" ")
            Volumes volumes = books.execute()
            render(view: "index", list: volumes.getItems())//falta el count que no funcionaba, si no hay criterio de busqueda mandar un texto que diga (no se encontraron resultados)
        }
    }

    def show(Book bookInstance) {
        respond bookInstance
    }

    def create() {
        respond new Book(params)
    }

    @Transactional
    def save(Book bookInstance) {
        if (bookInstance == null) {
            notFound()
            return
        }

        if (bookInstance.hasErrors()) {
            respond bookInstance.errors, view:'create'
            return
        }

        bookInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'book.label', default: 'Book'), bookInstance.id])
                redirect bookInstance
            }
            '*' { respond bookInstance, [status: CREATED] }
        }
    }

    def edit(Book bookInstance) {
        respond bookInstance
    }

    @Transactional
    def update(Book bookInstance) {
        if (bookInstance == null) {
            notFound()
            return
        }

        if (bookInstance.hasErrors()) {
            respond bookInstance.errors, view:'edit'
            return
        }

        bookInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Book.label', default: 'Book'), bookInstance.id])
                redirect bookInstance
            }
            '*'{ respond bookInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Book bookInstance) {

        if (bookInstance == null) {
            notFound()
            return
        }

        bookInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Book.label', default: 'Book'), bookInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def addBookToUser(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        println(params.user)
        if (params.user != null && params.bookId !=null && params.bookTitle != null){
            Book bookInstance = new Book()
            bookInstance.setBookId(params.bookId)
            bookInstance.setTitle(params.bookTitle)
            bookInstance.save(flush: true)
            User.get(params.user).addToBooks(bookInstance)
            User.get(params.user).save(flush: true)

            Books.Volumes.List books = googleBooksService.search(params.query)
            Volumes volumes = books.execute()
            render(view: "index", model: [ list: volumes.getItems(), query: params.query, user: params.user])//falta el count que no funcionaba
        }
    }

    def removeBookFromUser(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        if (params.bookId !=null){
            for (int i = 0; i < User.get(params.userId).getBooks().size(); i++) {

                if (User.get(params.userId).getBooks()[i].id == params.bookId as Integer){
                    println(params.bookId + "--" + User.get(params.userId).getBooks()[i].id)

                    User.get(params.userId).removeFromBooks(User.get(params.userId).getBooks()[i])
//                    getBooks()[i].delete()
                    User.get(params.userId).save(flush: true)
                }
            }
            render(view: "/user/wishList", model: [ list: User.get(params.userId).getBooks(), userId: params.userId])//falta el count que no funcionaba
        }
    }
}
