<%@ page import="googlebookswishlistproject.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'books', 'error')} ">
	<label for="books">
		<g:message code="user.books.label" default="Books" />
		
	</label>
	<g:select name="books" from="${googlebookswishlistproject.Book.list()}" multiple="multiple" optionKey="id" size="5" value="${userInstance?.books*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'firstName', 'error')} required">
	<label for="firstName">
		<g:message code="user.firstName.label" default="First Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstName" required="" value="${userInstance?.firstName}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'lastName', 'error')} required">
	<label for="lastName">
		<g:message code="user.lastName.label" default="Last Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="lastName" required="" value="${userInstance?.lastName}"/>

</div>

