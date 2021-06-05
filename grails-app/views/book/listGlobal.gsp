
%{--<%@ page import="googlebookswishlistproject.User" %>--}%
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message  />Books</title>
	</head>
	<body>
		<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				%{--<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
			</ul>
		</div>
		<div id="list-user" class="content scaffold-list" role="main">
			<h1><g:message/>Books List</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>

						<g:sortableColumn property="firstName" title="${message(code: 'user.firstName.label', default: 'Nombre')}" />

						<g:sortableColumn property="lastName" title="${message(code: 'user.lastName.label', default: 'Autor')}" />

					</tr>
				</thead>
				<tbody>
				%{--<g:each in="${userInstanceList}" status="i" var="userInstance">--}%
					%{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%

						%{--<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "firstName")}</g:link></td>--}%

						%{--<td>${fieldValue(bean: userInstance, field: "lastName")}</td>--}%

					%{--</tr>--}%
				%{--</g:each>--}%
				<g:each in="${list}" var="listt">
					<tr>
						<td>${listt.getVolumeInfo().getTitle()}</td>
						<td>${listt.getVolumeInfo().getAuthors()}</td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${count ?: 0}" />
			</div>
		</div>
	</body>
</html>
