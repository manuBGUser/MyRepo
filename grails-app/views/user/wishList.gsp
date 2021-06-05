
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message  />Wish List</title>
	</head>
	<body>
		<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message />Home</a></li>
                <li><g:link class="list" controller="user" action="index"><g:message />User List</g:link></li>
                <li><g:link class="list" controller="book" action="index" params="[userId: userId]">Add book</g:link></li>
			</ul>
		</div>
		<div id="list-user" class="content scaffold-list" role="main">
			<h1><g:message />Wish List</h1>

			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="firstName" title="${message(code: 'user.firstName.label', default: 'Title')}" />
					

						<g:sortableColumn property="lastName" title="${message(code: 'user.lastName.label', default: 'Action')}" />


					</tr>
				</thead>
				<tbody>
				<g:each in="${list}" var="listt">
					<tr>
						<td>${listt.getTitle()}</td>
						<td>
							<fieldset class="form">
								<g:form controller="book" action="removeBookFromUser" method="POST" params="[bookId: listt.id, userId: userId]">
									<div class="fieldcontain">
										<button id="addButton" type="submit">Remove</button>
									</div>
								</g:form>
							</fieldset>
						</td>

					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${userInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
