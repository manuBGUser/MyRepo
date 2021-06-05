<%@ page import="googlebookswishlistproject.Book" %>



<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'bookId', 'error')} required">
	<label for="bookId">
		<g:message code="book.bookId.label" default="Book Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="bookId" required="" value="${bookInstance?.bookId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="book.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${bookInstance?.title}"/>

</div>

