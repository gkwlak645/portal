<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Main Sidebar Container -->
<aside class="main-sidebar elevation-4 sidebar-light-primary">

    <!-- Brand Logo -->
    <a href="/main/siteMain" class="brand-link navbar-primary text-sm">
        <img src="/resources/images/dist/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image" style="opacity:1">
        <span class="brand-text font-weight-bold">RPA Portal</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">

	    <!-- Sidebar Menu -->
	    <nav class="mt-2">
	        <ul class="nav nav-pills nav-sidebar flex-column nav-flat nav-child-indent" data-widget="treeview" role="menu" data-accordion="false">
	            <!-- Add icons to the links using the .nav-icon class with font-awesome or any other icon font library -->
	            <tiles:importAttribute name="menuList" />
	            <c:if test="${menuList != null}">
	                <c:set var="beforeLevel" value="0"/>
	                <c:set var="treeOpen" value="0"/>
	                <c:set var="treeSelect" value="0"/>
	                <c:forEach var="menu" items="${menuList}" varStatus="status">
                        <c:if test="${menuCdList != null and menuCdList[0].inverseLvl eq '2' and menuCdList[0].menuCd eq menu.menuCd}">
                           <c:set var="treeOpen" value="1"/>
                        </c:if>
                        <c:if test="${menuCdList != null and menuCdList[0].inverseLvl eq '2' and menuCdList[0].menuCd ne menu.menuCd}">
                           <c:set var="treeOpen" value="0"/>
                        </c:if>
                        <c:if test="${menuCdList != null and menuCdList[1].inverseLvl eq '1' and menuCdList[1].menuCd eq menu.menuCd}">
                           <c:set var="treeSelect" value="1"/>
                        </c:if>
                        <c:if test="${menuCdList != null and menuCdList[1].inverseLvl eq '1' and menuCdList[1].menuCd ne menu.menuCd}">
                           <c:set var="treeSelect" value="0"/>
                        </c:if>
	                    <c:if test="${status.index != 0}">
	                        <c:if test="${(menu.menuLevel eq '1') and (beforeLevel ge menu.menuLevel)}">
	                            </li>
	                        </c:if>
	                    </c:if>
	                    <c:choose>
	                        <c:when test="${menu.menuLevel eq '1'}">
	                            <c:choose>
                                    <c:when test="${treeOpen eq '1'}">
					                    <li class="nav-item has-treeview menu-open">
                                        <a href="#" class="nav-link active">
                                            <c:choose>
                                                <c:when test="${menu.menuIconCours != null and menu.menuIconCours != ''}">
                                                    <i class="nav-icon fas <c:out value='${menu.menuIconCours}' />"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="nav-icon fas fa-tasks"></i>
                                                </c:otherwise>
                                            </c:choose>
                                            <p><c:out value="${menu.menuNm}"/><i class="fas fa-angle-left right"></i></p>
                                        </a>
					               </c:when>
					               <c:otherwise>
					                    <li class="nav-item has-treeview">
	                                    <a href="#" class="nav-link">
                                            <c:choose>
                                                <c:when test="${menu.menuIconCours != null and menu.menuIconCours != ''}">
                                                    <i class="nav-icon fas <c:out value='${menu.menuIconCours}' />"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="nav-icon fas fa-tasks"></i>
                                                </c:otherwise>
                                            </c:choose>
	                                        <p><c:out value="${menu.menuNm}"/><i class="right fas fa-angle-left"></i></p>
	                                    </a>
					               </c:otherwise>
					            </c:choose>
					        </c:when>
	                        <c:when test="${menu.menuLevel eq '2'}">
	                            <ul class="nav nav-treeview">
	                                <li class="nav-item">
	                                <c:choose>
	                                    <c:when test="${treeSelect eq '1'}">
		                                    <a href="<c:out value="${menu.menuUrl}"/>" class="nav-link active">
	                                            <i class="far fa-circle nav-icon"></i>
	                                            <p><c:out value="${menu.menuNm}"/></p>
	                                        </a>
	                                    </c:when>
	                                    <c:otherwise>
		                                    <a href="<c:out value="${menu.menuUrl}"/>" class="nav-link">
	                                            <i class="far fa-circle nav-icon"></i>
	                                            <p><c:out value="${menu.menuNm}"/></p>
	                                        </a>
	                                    </c:otherwise>
	                                </c:choose>
	                                </li>
	                            </ul>
	                        </c:when>
	                    </c:choose>
	                    <c:if test="${status.last}">
	                        </li>
	                    </c:if>
				        <c:set var="beforeLevel" value="${menu.menuLevel}"/>
	                </c:forEach>
	            </c:if>
	        </ul>
	    </nav>
	    <!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>
