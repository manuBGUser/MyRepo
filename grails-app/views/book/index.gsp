
<%@ page import="googlebookswishlistproject.Book" %>
<%@ page import="googlebookswishlistproject.User" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title><g:message  />Book List</title>
	</head>
	<body>
		<a href="#list-book" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message />Home</a></li>
				<li><g:link class="create" controller="user" action="wishList" params="[userId: user]"><g:message />User Wish List</g:link></li>
			</ul>
		</div>
		<div id="list-book" class="content scaffold-list" role="main">
			<h1><g:message />Book List</h1>
            %{--<h1>Make a search</h1>--}%
            <fieldset style="text-align: left" class="form">
                <g:form controller="book" action="search" method="POST" params="${[user: user]}">
                    <div class="fieldcontain">
                        <label for="query">Search for books:</label>
                        <g:textField name="query" value="${params.query}"/>
                    </div>
                </g:form>
            </fieldset>

			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="bookId" title="${message(code: 'book.bookId.label', default: 'Title')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'book.title.label', default: 'Authors')}" />

						<g:sortableColumn property="title" title="${message(code: 'book.title.label', default: 'Action')}" />


					</tr>
				</thead>
				<tbody>
				<g:each in="${list}" var="listt">
                    <g:set var="existe" value="${false}"/>
                    <g:each in="${User.list()}" var="useri">
                        <g:each in="${useri.getBooks()}" var="booki">
                            <g:if test="${booki.getBookId() == listt.getId()}">

                                <g:set var="existe" value="${true}"/>

                            </g:if>
                        </g:each>
                    </g:each>
                    <g:if test="${!existe}">
                        <tr>

                            <td>${listt.getVolumeInfo().getTitle()}</td>

                            <g:if test="${listt.getVolumeInfo().getAuthors() != null}">
                                <td>${listt.getVolumeInfo().getAuthors().join(", ")}</td>
                            </g:if>
                            <g:elseif test="${listt.getVolumeInfo().getAuthors() == null}">
                                <td></td>
                            </g:elseif>



                            <td>
                                <fieldset class="form">
                                    <g:form controller="book" action="addBookToUser" method="POST" params="${[bookId: listt.getId(), bookTitle: listt.getVolumeInfo().getTitle(), query: query]}">
                                        <div class="fieldcontain">
                                            <button id="addButton" type="submit">Add to wish list</button>
                                            <g:select style="visibility: hidden;" name="user" from="${User.get(user)}" optionKey="id" optionValue="firstName"></g:select>
                                        </div>
                                    </g:form>
                                </fieldset>
                            </td>

                        </tr>
                    </g:if>
                    <g:elseif test="${existe}">
                        <tr>

                            <td>${listt.getVolumeInfo().getTitle()}</td>

                            <g:if test="${listt.getVolumeInfo().getAuthors() != null}">
                                <td>${listt.getVolumeInfo().getAuthors().join(", ")}</td>
                            </g:if>
                            <g:elseif test="${listt.getVolumeInfo().getAuthors() == null}">
                                <td></td>
                            </g:elseif>


                            <td>
                                <fieldset class="form">
                                    <g:form controller="book" action="addBookToUser" method="POST" params="${[bookId: listt.getId(), bookTitle: listt.getVolumeInfo().getTitle(), query: query]}">
                                        <div class="fieldcontain">
                                            <button disabled="disabled" id="addButton" type="submit">In the wish list</button>
                                            %{--<g:select style="visibility: hidden;" name="user" from="${User.get(user)}" optionKey="id" optionValue="firstName"></g:select>--}%
                                        </div>
                                    </g:form>
                                </fieldset>
                            </td>

                        </tr>
                    </g:elseif>
                </g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${bookInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
