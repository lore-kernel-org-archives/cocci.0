From: thomas.adam22@gmail.com (Thomas Adam)
Date: Fri, 16 Dec 2016 13:13:54 +0000
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <alpine.DEB.2.10.1612161242300.3566@hadrien>
References: <20161216113410.4vauxw4u2f364l7v@fbsd-laptop>
 <alpine.DEB.2.10.1612161242300.3566@hadrien>
Message-ID: <20161216131350.5xc6awlrv2yu5xso@fbsd-laptop>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Dec 16, 2016 at 12:44:46PM +0100, Julia Lawall wrote:
> This is strange.  Because struct members are quite definitely covered by
> the expression metavariable.  Perhaps the function that contains this code
> incurs a parse error?  One way to see this is to say spatch --type-c
> file.c.  If you don't see any type annotations in a function then there is
> a problem.  You can also use --parse-c instead of --type-c to get some
> information about the precise problem.  But the output can be verbose.
> Look for the lines containing BAD.

Hi Julia,

Thank you for your reply.  Attached with this email is two files:

* type-c.out -- contains the output from running with --type-c.  Just for an
  example, there's a function in that output:  pkg_vset() which has a few
  calls to strdup() which aren't being matched.

* parse-c.out -- I don't see anything in there which explains the output from
  type-c.out

What should I be looking for?

Indeed -- even with the "--debug" flag, although there are lines marked as
"bad:" none of them relate to the functions I'm matching with strdup().

Thanks, Julia.  Anything you can suggest is much appreciated, and if you
require any further information, do not hesitate to ask.

Kindly,
Thomas
-------------- next part --------------
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
/*-
 * Copyright (c) 2011-2016 Baptiste Daroussin <bapt@FreeBSD.org>
 * Copyright (c) 2011-2012 Julien Laffaye <jlaffaye@FreeBSD.org>
 * Copyright (c) 2012 Bryan Drewery <bryan@shatow.net>
 * Copyright (c) 2013 Matthew Seaman <matthew@FreeBSD.org>
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer
 *    in this position and unchanged.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR(S) ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR(S) BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <archive.h>
#include <archive_entry.h>
#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <string.h>

#include "pkg.h"
#include "private/event.h"
#include "private/pkg.h"
#include "private/pkgdb.h"
#include "private/utils.h"

int
pkg_new(struct pkg **pkg, pkg_t type)
{
	if ((*pkg/*struct pkg**, local*//*struct pkg**/ = calloc/**/(1/*int*/, sizeof(struct pkg)/*size_t*/)/**//*struct pkg**/)/*struct pkg**/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("calloc"/*char[]*/, __func__/**/)/**/;
		return EPKG_FATAL/**/;
	}

	(*pkg/*struct pkg**, local*//*struct pkg**/)/*struct pkg**/->type/**/ = type/*pkg_t, local*//*pkg_t, local*/;
	(*pkg/*struct pkg**, local*//*struct pkg**/)/*struct pkg**/->rootfd/**/ = -1/*int*//*int*//*int*/;

	return (EPKG_OK/**/)/**/;
}

static void
pkg_message_free(struct pkg_message *m)
{
	free/**/(m/*struct pkg_message*, local*/->str/**/)/**/;
	free/**/(m/*struct pkg_message*, local*/->maximum_version/**/)/**/;
	free/**/(m/*struct pkg_message*, local*/->minimum_version/**/)/**/;
	free/**/(m/*struct pkg_message*, local*/)/**/;
}

void
pkg_free(struct pkg *pkg)
{
	if (pkg/*struct pkg*, local*/ == NULL/*void**//*int*/)
		return;

	free/**/(pkg/*struct pkg*, local*/->name/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->origin/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->old_version/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->maintainer/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->www/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->arch/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->abi/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->uid/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->digest/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->old_digest/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->prefix/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->comment/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->desc/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->sum/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->repopath/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->repourl/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->reason/**/)/**/;
	free/**/(pkg/*struct pkg*, local*/->dep_formula/**/)/**/;

	for (int i = 0/*int*/; i/*int, local*/ < PKG_NUM_SCRIPTS/**//*int*/; i/*int, local*/++/*int, local*/)
		if (pkg/*struct pkg*, local*/->scripts/**/[i/*int, local*/]/**/)
			utstring_free/**/(pkg/*struct pkg*, local*/->scripts/**/[i/*int, local*/]/**/)/**/;

	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_DEPS/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_RDEPS/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_FILES/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_DIRS/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_OPTIONS/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_USERS/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_GROUPS/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_SHLIBS_REQUIRED/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_SHLIBS_PROVIDED/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_PROVIDES/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_REQUIRES/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_CATEGORIES/**/)/**/;
	pkg_list_free/**/(pkg/*struct pkg*, local*/, PKG_LICENSES/**/)/**/;

	LL_FREE/**/(pkg/*struct pkg*, local*/->message/**/,
		    pkg_message_free/*void(struct pkg_message*m)*/)/**/;
	LL_FREE/**/(pkg/*struct pkg*, local*/->annotations/**/,
		    pkg_kv_free/**/)/**/;

	if (pkg/*struct pkg*, local*/->rootfd/**/ != -1/*int*//*int*//*int*/)
		close/**/(pkg/*struct pkg*, local*/->rootfd/**/)/**/;

	free/**/(pkg/*struct pkg*, local*/)/**/;
}

pkg_t
pkg_type(const struct pkg * restrict pkg)
{
	assert/**/(pkg/*const struct pkg*, local*/ != NULL/*void**//*int*/)/**/;

	return (pkg/*const struct pkg*, local*/->type/**/)/**/;
}

int
pkg_is_valid(const struct pkg * restrict pkg)
{
	if (pkg/*const struct pkg*, local*/ == NULL/*void**//*int*/) {
		pkg_emit_error/**/("Invalid package: not allocated"/*char[]*/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	if (pkg/*const struct pkg*, local*/->origin/**/ == NULL/*void**//*int*/) {
		pkg_emit_error/**/("Invalid package: object has missing property origin"/*char[]*/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	if (pkg/*const struct pkg*, local*/->name/**/ == NULL/*void**//*int*/) {
		pkg_emit_error/**/("Invalid package: object has missing property name"/*char[]*/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	if (pkg/*const struct pkg*, local*/->comment/**/ == NULL/*void**//*int*/) {
		pkg_emit_error/**/("Invalid package: object has missing property comment"/*char[]*/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	if (pkg/*const struct pkg*, local*/->version/**/ == NULL/*void**//*int*/) {
		pkg_emit_error/**/("Invalid package: object has missing property version"/*char[]*/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	if (pkg/*const struct pkg*, local*/->desc/**/ == NULL/*void**//*int*/) {
		pkg_emit_error/**/("Invalid package: object has missing property desc"/*char[]*/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	if (pkg/*const struct pkg*, local*/->maintainer/**/ == NULL/*void**//*int*/) {
		pkg_emit_error/**/("Invalid package: object has missing property maintainer"/*char[]*/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	if (pkg/*const struct pkg*, local*/->www/**/ == NULL/*void**//*int*/) {
		pkg_emit_error/**/("Invalid package: object has missing property www"/*char[]*/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	if (pkg/*const struct pkg*, local*/->prefix/**/ == NULL/*void**//*int*/) {
		pkg_emit_error/**/("Invalid package: object has missing property prefix"/*char[]*/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	return (EPKG_OK/**/)/**/;
}

static int
pkg_vget(const struct pkg * restrict pkg, va_list ap)
{
	int attr;

	while ((attr/*int, local*/ = va_arg/**/(ap/*va_list, local*/, int)/**//*int, local*/)/*int, local*/ > 0/*int*//*int*/) {

		if (attr/*int, local*/ >= PKG_NUM_FIELDS/**//*int*/ || attr/*int, local*/ <= 0/*int*//*int*//*int*/) {
			pkg_emit_error/**/("Bad argument on pkg_get %d"/*char[]*/, attr/*int, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}

		switch (attr/*int, local*/) {
		case PKG_ORIGIN/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->origin/**//**/;
			break;
		case PKG_NAME/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->name/**//**/;
			break;
		case PKG_VERSION/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->version/**//**/;
			break;
		case PKG_COMMENT/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->comment/**//**/;
			break;
		case PKG_DESC/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->desc/**//**/;
			break;
		case PKG_MTREE/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = NULL/*void**//*void**/;
			break;
		case PKG_MESSAGE/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->message/**/ ? pkg/*const struct pkg*, local*/->message/**/->str/**/ : NULL/*void**//*void**//*void**/;
			break;
		case PKG_ARCH/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->arch/**//**/;
			break;
		case PKG_ABI/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->abi/**//**/;
			break;
		case PKG_WWW/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->www/**//**/;
			break;
		case PKG_MAINTAINER/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->maintainer/**//**/;
			break;
		case PKG_PREFIX/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->prefix/**//**/;
			break;
		case PKG_REPOPATH/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->repopath/**//**/;
			break;
		case PKG_CKSUM/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->sum/**//**/;
			break;
		case PKG_OLD_VERSION/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->old_version/**//**/;
			break;
		case PKG_REPONAME/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->reponame/**//**/;
			break;
		case PKG_REPOURL/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->repourl/**//**/;
			break;
		case PKG_DIGEST/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->digest/**//**/;
			break;
		case PKG_REASON/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->reason/**//**/;
			break;
		case PKG_FLATSIZE/**/:
			*va_arg/**/(ap/*va_list, local*/, int64_t *)/**//**/ = pkg/*const struct pkg*, local*/->flatsize/**//**/;
			break;
		case PKG_OLD_FLATSIZE/**/:
			*va_arg/**/(ap/*va_list, local*/, int64_t *)/**//**/ = pkg/*const struct pkg*, local*/->old_flatsize/**//**/;
			break;
		case PKG_PKGSIZE/**/:
			*va_arg/**/(ap/*va_list, local*/, int64_t *)/**//**/ = pkg/*const struct pkg*, local*/->pkgsize/**//**/;
			break;
		case PKG_LICENSE_LOGIC/**/:
			*va_arg/**/(ap/*va_list, local*/, lic_t *)/**//**/ = pkg/*const struct pkg*, local*/->licenselogic/**//**/;
			break;
		case PKG_AUTOMATIC/**/:
			*va_arg/**/(ap/*va_list, local*/, bool *)/**//**/ = pkg/*const struct pkg*, local*/->automatic/**//**/;
			break;
		case PKG_LOCKED/**/:
			*va_arg/**/(ap/*va_list, local*/, bool *)/**//**/ = pkg/*const struct pkg*, local*/->locked/**//**/;
			break;
		case PKG_ROWID/**/:
			*va_arg/**/(ap/*va_list, local*/, int64_t *)/**//**/ = pkg/*const struct pkg*, local*/->id/**//**/;
			break;
		case PKG_TIME/**/:
			*va_arg/**/(ap/*va_list, local*/, int64_t *)/**//**/ = pkg/*const struct pkg*, local*/->timestamp/**//**/;
			break;
		case PKG_ANNOTATIONS/**/:
			*va_arg/**/(ap/*va_list, local*/, const struct pkg_kv **)/**//**/ = pkg/*const struct pkg*, local*/->annotations/**//**/;
			break;
		case PKG_UNIQUEID/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->uid/**//**/;
			break;
		case PKG_OLD_DIGEST/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->old_digest/**//**/;
			break;
		case PKG_DEP_FORMULA/**/:
			*va_arg/**/(ap/*va_list, local*/, const char **)/**//**/ = pkg/*const struct pkg*, local*/->dep_formula/**//**/;
			break;
		case PKG_VITAL/**/:
			*va_arg/**/(ap/*va_list, local*/, bool *)/**//**/ = pkg/*const struct pkg*, local*/->vital/**//**/;
			break;
		}
	}

	return (EPKG_OK/**/)/**/;
}

int
pkg_get2(const struct pkg * restrict pkg, ...)
{
	int ret = EPKG_OK/**/;
	va_list ap;

	assert/**/(pkg/*const struct pkg*, local*/ != NULL/*void**//*int*/)/**/;

	va_start/**/(ap/*va_list, local*/, pkg/*const struct pkg*, local*/)/**/;
	ret/*int, local*/ = pkg_vget/*int(const struct pkg*pkg va_list ap)*/(pkg/*const struct pkg*, local*/,
									     ap/*va_list, local*/)/*int*//*int, local*/;
	va_end/**/(ap/*va_list, local*/)/**/;

	return (ret/*int, local*/)/*int, local*/;
}

static int
pkg_vset(struct pkg *pkg, va_list ap)
{
	int attr;
	const char *buf;
	ucl_object_t *obj;
	struct pkg_message *msg;

	while ((attr/*int, local*/ = va_arg/**/(ap/*va_list, local*/, int)/**//*int, local*/)/*int, local*/ > 0/*int*//*int*/) {
		if (attr/*int, local*/ >= PKG_NUM_FIELDS/**//*int*/ || attr/*int, local*/ <= 0/*int*//*int*//*int*/) {
			pkg_emit_error/**/("Bad argument on pkg_set %d"/*char[]*/, attr/*int, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}

		switch (attr/*int, local*/) {
		case PKG_NAME/**/:
			free/**/(pkg/*struct pkg*, local*/->name/**/)/**/;
			pkg/*struct pkg*, local*/->name/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			free/**/(pkg/*struct pkg*, local*/->uid/**/)/**/;
			pkg/*struct pkg*, local*/->uid/**/ = strdup/**/(pkg/*struct pkg*, local*/->name/**/)/**//**/;
			break;
		case PKG_ORIGIN/**/:
			free/**/(pkg/*struct pkg*, local*/->origin/**/)/**/;
			pkg/*struct pkg*, local*/->origin/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_VERSION/**/:
			free/**/(pkg/*struct pkg*, local*/->version/**/)/**/;
			pkg/*struct pkg*, local*/->version/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_COMMENT/**/:
			free/**/(pkg/*struct pkg*, local*/->comment/**/)/**/;
			pkg/*struct pkg*, local*/->comment/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_DESC/**/:
			free/**/(pkg/*struct pkg*, local*/->desc/**/)/**/;
			pkg/*struct pkg*, local*/->desc/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_MTREE/**/:
			(void)va_arg/**/(ap/*va_list, local*/, const char *)/**//*void*/;
			break;
		case PKG_MESSAGE/**/:
			LL_FOREACH(pkg/*struct pkg*, local*/->message/**/,
				   msg/*struct pkg_message*, local*/) {
				pkg_message_free/*void(struct pkg_message*m)*/(msg/*struct pkg_message*, local*/)/*void*/;
			}
			buf/*const char*, local*/ = va_arg/**/(ap/*va_list, local*/, const char *)/**//*const char*, local*/;
			if (*buf/*const char*, local*//*const char*/ == '['/*char*//*int*/) {
				pkg_message_from_str/**/(pkg/*struct pkg*, local*/,
							 buf/*const char*, local*/,
							 strlen/**/(buf/*const char*, local*/)/**/)/**/;
			} else {
				obj/*ucl_object_t*, local*/ = ucl_object_fromstring_common/**/(buf/*const char*, local*/,
											       strlen/**/(buf/*const char*, local*/)/**/,
											       UCL_STRING_RAW/**/|UCL_STRING_TRIM/**//**/)/**//*ucl_object_t*, local*/;
				pkg_message_from_ucl/**/(pkg/*struct pkg*, local*/,
							 obj/*ucl_object_t*, local*/)/**/;
				ucl_object_unref/**/(obj/*ucl_object_t*, local*/)/**/;
			}
			break;
		case PKG_ARCH/**/:
			free/**/(pkg/*struct pkg*, local*/->arch/**/)/**/;
			pkg/*struct pkg*, local*/->arch/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_ABI/**/:
			free/**/(pkg/*struct pkg*, local*/->abi/**/)/**/;
			pkg/*struct pkg*, local*/->abi/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_MAINTAINER/**/:
			free/**/(pkg/*struct pkg*, local*/->maintainer/**/)/**/;
			pkg/*struct pkg*, local*/->maintainer/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_WWW/**/:
			free/**/(pkg/*struct pkg*, local*/->www/**/)/**/;
			pkg/*struct pkg*, local*/->www/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_PREFIX/**/:
			free/**/(pkg/*struct pkg*, local*/->prefix/**/)/**/;
			pkg/*struct pkg*, local*/->prefix/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_REPOPATH/**/:
			free/**/(pkg/*struct pkg*, local*/->repopath/**/)/**/;
			pkg/*struct pkg*, local*/->repopath/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_CKSUM/**/:
			free/**/(pkg/*struct pkg*, local*/->sum/**/)/**/;
			pkg/*struct pkg*, local*/->sum/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_OLD_VERSION/**/:
			free/**/(pkg/*struct pkg*, local*/->old_version/**/)/**/;
			pkg/*struct pkg*, local*/->old_version/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_REPONAME/**/:
			free/**/(pkg/*struct pkg*, local*/->reponame/**/)/**/;
			pkg/*struct pkg*, local*/->reponame/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_REPOURL/**/:
			free/**/(pkg/*struct pkg*, local*/->repourl/**/)/**/;
			pkg/*struct pkg*, local*/->repourl/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_DIGEST/**/:
			free/**/(pkg/*struct pkg*, local*/->digest/**/)/**/;
			pkg/*struct pkg*, local*/->digest/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_REASON/**/:
			free/**/(pkg/*struct pkg*, local*/->reason/**/)/**/;
			pkg/*struct pkg*, local*/->reason/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_FLATSIZE/**/:
			pkg/*struct pkg*, local*/->flatsize/**/ = va_arg/**/(ap/*va_list, local*/, int64_t)/**//**/;
			break;
		case PKG_OLD_FLATSIZE/**/:
			pkg/*struct pkg*, local*/->old_flatsize/**/ = va_arg/**/(ap/*va_list, local*/, int64_t)/**//**/;
			break;
		case PKG_PKGSIZE/**/:
			pkg/*struct pkg*, local*/->pkgsize/**/ = va_arg/**/(ap/*va_list, local*/, int64_t)/**//**/;
			break;
		case PKG_LICENSE_LOGIC/**/:
			pkg/*struct pkg*, local*/->licenselogic/**/ = (lic_t)va_arg/**/(ap/*va_list, local*/, int)/**//*lic_t*//*lic_t*/;
			break;
		case PKG_AUTOMATIC/**/:
			pkg/*struct pkg*, local*/->automatic/**/ = (bool)va_arg/**/(ap/*va_list, local*/, int)/**//*bool*//*bool*/;
			break;
		case PKG_ROWID/**/:
			pkg/*struct pkg*, local*/->id/**/ = va_arg/**/(ap/*va_list, local*/, int64_t)/**//**/;
			break;
		case PKG_LOCKED/**/:
			pkg/*struct pkg*, local*/->locked/**/ = (bool)va_arg/**/(ap/*va_list, local*/, int)/**//*bool*//*bool*/;
			break;
		case PKG_TIME/**/:
			pkg/*struct pkg*, local*/->timestamp/**/ = va_arg/**/(ap/*va_list, local*/, int64_t)/**//**/;
			break;
		case PKG_DEP_FORMULA/**/:
			free/**/(pkg/*struct pkg*, local*/->dep_formula/**/)/**/;
			pkg/*struct pkg*, local*/->dep_formula/**/ = strdup/**/(va_arg/**/(ap/*va_list, local*/, const char *)/**/)/**//**/;
			break;
		case PKG_VITAL/**/:
			pkg/*struct pkg*, local*/->vital/**/ = (bool)va_arg/**/(ap/*va_list, local*/, int)/**//*bool*//*bool*/;
			break;
		}
	}

	return (EPKG_OK/**/)/**/;
}

int
pkg_set2(struct pkg *pkg, ...)
{
	int ret = EPKG_OK/**/;
	va_list ap;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;

	va_start/**/(ap/*va_list, local*/, pkg/*struct pkg*, local*/)/**/;
	ret/*int, local*/ = pkg_vset/*int(struct pkg*pkg va_list ap)*/(pkg/*struct pkg*, local*/,
								       ap/*va_list, local*/)/*int*//*int, local*/;
	va_end/**/(ap/*va_list, local*/)/**/;

	return (ret/*int, local*/)/*int, local*/;
}

int
pkg_set_from_fileat(int fd, struct pkg *pkg, pkg_attr attr, const char *path,
    bool trimcr)
{
	char *buf = NULL/*void**/;
	char *cp;
	off_t size = 0/*int*/;
	int ret = EPKG_OK/**/;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(path/*const char*, local*/ != NULL/*void**//*int*/)/**/;

	if ((ret/*int, local*/ = file_to_bufferat/**/(fd/*int, local*/, path/*const char*, local*/, &buf/*char*, local*//*char***/, &size/*off_t, local*//*off_t**/)/**//*int, local*/)/*int, local*/ !=  EPKG_OK/**//*int*/)
		return (ret/*int, local*/)/*int, local*/;

	if (trimcr/*bool, local*/) {
		cp/*char*, local*/ = buf/*char*, local*/ + strlen/**/(buf/*char*, local*/)/**//*char**/ - 1/*int*//*char**//*char*, local*/;
		while (cp/*char*, local*/ > buf/*char*, local*//*int*/ && *cp/*char*, local*//*char*/ == '\n'/*char*//*int*//*int*/) {
			*cp/*char*, local*//*char*/ = 0/*int*//*char*/;
			cp/*char*, local*/--/*char*, local*/;
		}
	}

	ret/*int, local*/ = pkg_set/**/(pkg/*struct pkg*, local*/,
					attr/*pkg_attr, local*/,
					buf/*char*, local*/)/**//*int, local*/;

	free/**/(buf/*char*, local*/)/**/;

	return (ret/*int, local*/)/*int, local*/;
}

int
pkg_set_from_file(struct pkg *pkg, pkg_attr attr, const char *path, bool trimcr)
{
	char *buf = NULL/*void**/;
	char *cp;
	off_t size = 0/*int*/;
	int ret = EPKG_OK/**/;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(path/*const char*, local*/ != NULL/*void**//*int*/)/**/;

	if ((ret/*int, local*/ = file_to_buffer/**/(path/*const char*, local*/, &buf/*char*, local*//*char***/, &size/*off_t, local*//*off_t**/)/**//*int, local*/)/*int, local*/ !=  EPKG_OK/**//*int*/)
		return (ret/*int, local*/)/*int, local*/;

	if (trimcr/*bool, local*/) {
		cp/*char*, local*/ = buf/*char*, local*/ + strlen/**/(buf/*char*, local*/)/**//*char**/ - 1/*int*//*char**//*char*, local*/;
		while (cp/*char*, local*/ > buf/*char*, local*//*int*/ && *cp/*char*, local*//*char*/ == '\n'/*char*//*int*//*int*/) {
			*cp/*char*, local*//*char*/ = 0/*int*//*char*/;
			cp/*char*, local*/--/*char*, local*/;
		}
	}

	ret/*int, local*/ = pkg_set/**/(pkg/*struct pkg*, local*/,
					attr/*pkg_attr, local*/,
					buf/*char*, local*/)/**//*int, local*/;

	free/**/(buf/*char*, local*/)/**/;

	return (ret/*int, local*/)/*int, local*/;
}

int
pkg_options(const struct pkg *pkg, struct pkg_option **o)
{
	assert/**/(pkg/*const struct pkg*, local*/ != NULL/*void**//*int*/)/**/;

	HASH_NEXT/**/(pkg/*const struct pkg*, local*/->options/**/,
		      (*o/*struct pkg_option**, local*//*struct pkg_option**/)/*struct pkg_option**/)/**/;
}

int
pkg_conflicts(const struct pkg *pkg, struct pkg_conflict **c)
{
	assert/**/(pkg/*const struct pkg*, local*/ != NULL/*void**//*int*/)/**/;

	HASH_NEXT/**/(pkg/*const struct pkg*, local*/->conflicts/**/,
		      (*c/*struct pkg_conflict**, local*//*struct pkg_conflict**/)/*struct pkg_conflict**/)/**/;
}

#define pkg_each(name, type, field)		\
int						\
pkg_##name(const struct pkg *p, type **t) {	\
	assert/**/(p/**/ != NULL/*void**//*int*/)/**/;			\
	if ((*t/**//**/)/**/ == NULL/*void**//*int*/)			\
		(*t/**//**/)/**/ = p/**/->field/**//**/;		\
	else					\
		(*t/**//**/)/**/ = (*t/**//**/)/**/->next/**//**/;		\
	if ((*t/**//**/)/**/ == NULL/*void**//*int*/)			\
		return (EPKG_END/**/)/**/;		\
	return (EPKG_OK/**/)/**/;			\
}

pkg_each(dirs/**/, struct pkg_dir, dirs/**/);
pkg_each(files/**/, struct pkg_file, files/**/);
pkg_each(deps/**/, struct pkg_dep, depends/**/);
pkg_each(rdeps/**/, struct pkg_dep, rdepends/**/);

#define pkg_each_hash(name, htype, type, attrib)	\
int							\
pkg_##name(const struct pkg *pkg, type **c) {		\
	assert/**/(pkg/**/ != NULL/*void**//*int*/)/**/;				\
	kh_next/**/(htype/**/, pkg/**/->name/**/, (*c/**//**/)/**/, attrib/**/)/**/;	\
}
pkg_each_hash(config_files/**/, pkg_config_files/**/, struct pkg_config_file, path/**/);

#define pkg_each_strings(name)			\
int						\
pkg_##name(const struct pkg *pkg, char **c) {	\
	assert/**/(pkg/**/ != NULL/*void**//*int*/)/**/;			\
	kh_string_next/**/(pkg/**/->name/**/, (*c/**//**/)/**/)/**/;	\
}

pkg_each_strings(categories/**/);
pkg_each_strings(licenses/**/);
pkg_each_strings(requires/**/);
pkg_each_strings(provides/**/);
pkg_each_strings(shlibs_required/**/);
pkg_each_strings(shlibs_provided/**/);
pkg_each_strings(users/**/);
pkg_each_strings(groups/**/);

int
pkg_adduser(struct pkg *pkg, const char *name)
{
	char *storename;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(name/*const char*, local*/ != NULL/*void**//*int*/ && name/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	if (kh_contains/**/(strings/**/, pkg/*struct pkg*, local*/->users/**/, name/*const char*, local*/)/**/) {
		if (developer_mode/**/) {
			pkg_emit_error/**/("duplicate user listing: %s, fatal (developer mode)"/*char[]*/,
					   name/*const char*, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		} else {
			pkg_emit_error/**/("duplicate user listing: %s, ignoring"/*char[]*/,
					   name/*const char*, local*/)/**/;
			return (EPKG_OK/**/)/**/;
		}
	}

	storename/*char*, local*/ = strdup/**/(name/*const char*, local*/)/**//*char*, local*/;
	if (storename/*char*, local*/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	kh_add/**/(strings/**/, pkg/*struct pkg*, local*/->users/**/,
		   storename/*char*, local*/, storename/*char*, local*/,
		   free/**/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addgroup(struct pkg *pkg, const char *name)
{
	char *storename;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(name/*const char*, local*/ != NULL/*void**//*int*/ && name/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	if (kh_contains/**/(strings/**/, pkg/*struct pkg*, local*/->groups/**/, name/*const char*, local*/)/**/) {
		if (developer_mode/**/) {
			pkg_emit_error/**/("duplicate group listing: %s, fatal (developer mode)"/*char[]*/,
					   name/*const char*, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		} else {
			pkg_emit_error/**/("duplicate group listing: %s, ignoring"/*char[]*/,
					   name/*const char*, local*/)/**/;
			return (EPKG_OK/**/)/**/;
		}
	}

	storename/*char*, local*/ = strdup/**/(name/*const char*, local*/)/**//*char*, local*/;
	if (storename/*char*, local*/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	kh_add/**/(strings/**/, pkg/*struct pkg*, local*/->groups/**/,
		   storename/*char*, local*/, storename/*char*, local*/,
		   free/**/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_adddep(struct pkg *pkg, const char *name, const char *origin, const char *version, bool locked)
{
	struct pkg_dep *d = NULL;

	assert(pkg != NULL);
	assert(name != NULL && name[0] != '\0');
	assert(origin != NULL && origin[0] != '\0');

	pkg_debug(3, "Pkg: add a new dependency origin: %s, name: %s", origin, name);
	if (kh_contains(pkg_deps, pkg->depshash, name)) {
		if (developer_mode) {
			pkg_emit_error("%s: duplicate dependency listing: %s, fatal (developer mode)",
			    pkg->name, name);
			return (EPKG_FATAL);
		} else {
			pkg_emit_error("%s-%s: duplicate dependency listing: %s, ignoring",
			    pkg->name, pkg->version, name);
			return (EPKG_OK);
		}
	}

	pkg_dep_new(&d);

	d->origin = strdup(origin);
	if (d->origin == NULL) {
		pkg_emit_errno("strdup", __func__);
		return (EPKG_FATAL);
	}
	d->name = strdup(name);
	if (d->name == NULL) {
		pkg_emit_errno("strdup", __func__);
		return (EPKG_FATAL);
	}
	if (version != NULL && version[0] != '\0') {
		d->version = strdup(version);
		if (d->version == NULL) {
			pkg_emit_errno("strdup", __func__);
			return (EPKG_FATAL);
	}
	d->uid = strdup(name);
	if (d->uid == NULL) {
		pkg_emit_errno("strdup", __func__);
		return (EPKG_FATAL);
	}
	d->locked = locked;

	kh_add(pkg_deps, pkg->depshash, d, d->name, pkg_dep_free);
	LL_APPEND(pkg->depends, d);

	return (EPKG_OK);
}

int
pkg_addrdep(struct pkg *pkg, const char *name, const char *origin, const char *version, bool locked)
{
	struct pkg_dep *d;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(name/*const char*, local*/ != NULL/*void**//*int*/ && name/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;
	assert/**/(origin/*const char*, local*/ != NULL/*void**//*int*/ && origin/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	pkg_debug/**/(3/*int*/, "Pkg: add a new reverse dependency origin: %s, name: %s"/*char[]*/,
		      origin/*const char*, local*/,
		      name/*const char*, local*/)/**/;
	pkg_dep_new/**/(&d/*struct pkg_dep*, local*//*struct pkg_dep***/)/**/;

	d/*struct pkg_dep*, local*/->origin/**/ = strdup/**/(origin/*const char*, local*/)/**//**/;
	if (d/*struct pkg_dep*, local*/->origin/**/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	d/*struct pkg_dep*, local*/->name/**/ = strdup/**/(name/*const char*, local*/)/**//**/;
	if (d/*struct pkg_dep*, local*/->name/**/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	if (version/*const char*, local*/ != NULL/*void**//*int*/ && version/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/) {
		d/*struct pkg_dep*, local*/->version/**/ = strdup/**/(version/*const char*, local*/)/**//**/;
		if (d/*struct pkg_dep*, local*/->version/**/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
	}
	d/*struct pkg_dep*, local*/->uid/**/ = strdup/**/(name/*const char*, local*/)/**//**/;
	if (d/*struct pkg_dep*, local*/->uid/**/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	d/*struct pkg_dep*, local*/->locked/**/ = locked/*bool, local*//*bool, local*/;

	kh_add/**/(pkg_deps/**/, pkg/*struct pkg*, local*/->rdepshash/**/,
		   d/*struct pkg_dep*, local*/,
		   d/*struct pkg_dep*, local*/->name/**/, pkg_dep_free/**/)/**/;
	LL_APPEND/**/(pkg/*struct pkg*, local*/->rdepends/**/,
		      d/*struct pkg_dep*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addfile(struct pkg *pkg, const char *path, const char *sum, bool check_duplicates)
{
	return (pkg_addfile_attr/**/(pkg/*struct pkg*, local*/, path/*const char*, local*/, sum/*const char*, local*/, NULL/*void**/, NULL/*void**/, 0/*int*/, 0/*int*/, check_duplicates/*bool, local*/)/**/)/**/;
}

int
pkg_addfile_attr(struct pkg *pkg, const char *path, const char *sum,
    const char *uname, const char *gname, mode_t perm, u_long fflags,
    bool check_duplicates)
{
	struct pkg_file *f = NULL/*void**/;
	char abspath[MAXPATHLEN/**/];

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(path/*const char*, local*/ != NULL/*void**//*int*/ && path/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	path/*const char*, local*/ = pkg_absolutepath/**/(path/*const char*, local*/,
							  abspath/*char[MAXPATHLEN/**/], local*/,
							  sizeof(abspath/*char[MAXPATHLEN/**/], local*/)/*char[MAXPATHLEN/**/], local*//*size_t*/,
							  false/**/)/**//*const char*, local*/;
	pkg_debug/**/(3/*int*/, "Pkg: add new file '%s'"/*char[]*/,
		      path/*const char*, local*/)/**/;

	if (check_duplicates/*bool, local*/ && kh_contains/**/(pkg_files/**/, pkg/*struct pkg*, local*/->filehash/**/, path/*const char*, local*/)/**//*int*/) {
		if (developer_mode/**/) {
			pkg_emit_error/**/("duplicate file listing: %s, fatal (developer mode)"/*char[]*/,
					   path/*const char*, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		} else {
			pkg_emit_error/**/("duplicate file listing: %s, ignoring"/*char[]*/,
					   path/*const char*, local*/)/**/;
			return (EPKG_OK/**/)/**/;
		}
	}

	pkg_file_new/**/(&f/*struct pkg_file*, local*//*struct pkg_file***/)/**/;
	strlcpy/**/(f/*struct pkg_file*, local*/->path/**/,
		    path/*const char*, local*/,
		    sizeof(f/*struct pkg_file*, local*/->path/**/)/**//*size_t*/)/**/;

	if (sum/*const char*, local*/ != NULL/*void**//*int*/) {
		f/*struct pkg_file*, local*/->sum/**/ = strdup/**/(sum/*const char*, local*/)/**//**/;
		if (f/*struct pkg_file*, local*/->sum/**/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
	}

	if (uname/*const char*, local*/ != NULL/*void**//*int*/)
		strlcpy/**/(f/*struct pkg_file*, local*/->uname/**/,
			    uname/*const char*, local*/,
			    sizeof(f/*struct pkg_file*, local*/->uname/**/)/**//*size_t*/)/**/;

	if (gname/*const char*, local*/ != NULL/*void**//*int*/)
		strlcpy/**/(f/*struct pkg_file*, local*/->gname/**/,
			    gname/*const char*, local*/,
			    sizeof(f/*struct pkg_file*, local*/->gname/**/)/**//*size_t*/)/**/;

	if (perm/*mode_t, local*/ != 0/*int*//*int*/)
		f/*struct pkg_file*, local*/->perm/**/ = perm/*mode_t, local*//*mode_t, local*/;

	if (fflags/*u_long, local*/ != 0/*int*//*int*/)
		f/*struct pkg_file*, local*/->fflags/**/ = fflags/*u_long, local*//*u_long, local*/;

	kh_safe_add/**/(pkg_files/**/,
			pkg/*struct pkg*, local*/->filehash/**/,
			f/*struct pkg_file*, local*/,
			f/*struct pkg_file*, local*/->path/**/)/**/;
	LL_APPEND/**/(pkg/*struct pkg*, local*/->files/**/,
		      f/*struct pkg_file*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addconfig_file(struct pkg *pkg, const char *path, const char *content)
{
	struct pkg_config_file *f = NULL/*void**/;
	char abspath[MAXPATHLEN/**/];

	path/*const char*, local*/ = pkg_absolutepath/**/(path/*const char*, local*/,
							  abspath/*char[MAXPATHLEN/**/], local*/,
							  sizeof(abspath/*char[MAXPATHLEN/**/], local*/)/*char[MAXPATHLEN/**/], local*//*size_t*/,
							  false/**/)/**//*const char*, local*/;
	pkg_debug/**/(3/*int*/, "Pkg: add new config file '%s'"/*char[]*/,
		      path/*const char*, local*/)/**/;

	if (kh_contains/**/(pkg_config_files/**/, pkg/*struct pkg*, local*/->config_files/**/, path/*const char*, local*/)/**/) {
		if (developer_mode/**/) {
			pkg_emit_error/**/("duplicate file listing: %s, fatal (developer mode)"/*char[]*/,
					   path/*const char*, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		} else {
			pkg_emit_error/**/("duplicate file listing: %s, ignoring"/*char[]*/,
					   path/*const char*, local*/)/**/;
		}
	}
	pkg_config_file_new/**/(&f/*struct pkg_config_file*, local*//*struct pkg_config_file***/)/**/;
	strlcpy/**/(f/*struct pkg_config_file*, local*/->path/**/,
		    path/*const char*, local*/,
		    sizeof(f/*struct pkg_config_file*, local*/->path/**/)/**//*size_t*/)/**/;

	if (content/*const char*, local*/ != NULL/*void**//*int*/) {
		f/*struct pkg_config_file*, local*/->content/**/ = strdup/**/(content/*const char*, local*/)/**//**/;
		if (f/*struct pkg_config_file*, local*/->content/**/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
	}

	kh_add/**/(pkg_config_files/**/,
		   pkg/*struct pkg*, local*/->config_files/**/,
		   f/*struct pkg_config_file*, local*/,
		   f/*struct pkg_config_file*, local*/->path/**/,
		   pkg_config_file_free/**/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addstring(kh_strings_t **list, const char *val, const char *title)
{
	char *store;

	assert/**/(val/*const char*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(title/*const char*, local*/ != NULL/*void**//*int*/)/**/;

	if (kh_contains/**/(strings/**/, *list/*kh_strings_t**, local*//*kh_strings_t**/, val/*const char*, local*/)/**/) {
		if (developer_mode/**/) {
			pkg_emit_error/**/("duplicate %s listing: %s, fatal"
			    " (developer mode)"/*char[]*/,
			    title/*const char*, local*/,
			    val/*const char*, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		} else {
			pkg_emit_error/**/("duplicate %s listing: %s, "
			    "ignoring"/*char[]*/, title/*const char*, local*/,
			    val/*const char*, local*/)/**/;
			return (EPKG_OK/**/)/**/;
		}
	}

	store/*char*, local*/ = strdup/**/(val/*const char*, local*/)/**//*char*, local*/;
	if (store/*char*, local*/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	kh_add/**/(strings/**/, *list/*kh_strings_t**, local*//*kh_strings_t**/, store/*char*, local*/, store/*char*, local*/, free/**/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_adddir(struct pkg *pkg, const char *path, bool check_duplicates)
{
	return(pkg_adddir_attr/**/(pkg/*struct pkg*, local*/, path/*const char*, local*/, NULL/*void**/, NULL/*void**/, 0/*int*/, 0/*int*/, check_duplicates/*bool, local*/)/**/)/**/;
}

int
pkg_adddir_attr(struct pkg *pkg, const char *path, const char *uname,
    const char *gname, mode_t perm, u_long fflags, bool check_duplicates)
{
	struct pkg_dir *d = NULL/*void**/;
	char abspath[MAXPATHLEN/**/];

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(path/*const char*, local*/ != NULL/*void**//*int*/ && path/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	if (strcmp/**/(path/*const char*, local*/, "/"/*char[]*/)/**/ == 0/*int*//*int*/) {
		pkg_emit_error/**/("skipping useless directory: '%s'\n"/*char[]*/,
				   path/*const char*, local*/)/**/;
		return (EPKG_OK/**/)/**/;
	}
	path/*const char*, local*/ = pkg_absolutepath/**/(path/*const char*, local*/,
							  abspath/*char[MAXPATHLEN/**/], local*/,
							  sizeof(abspath/*char[MAXPATHLEN/**/], local*/)/*char[MAXPATHLEN/**/], local*//*size_t*/,
							  false/**/)/**//*const char*, local*/;
	pkg_debug/**/(3/*int*/, "Pkg: add new directory '%s'"/*char[]*/,
		      path/*const char*, local*/)/**/;
	if (check_duplicates/*bool, local*/ && kh_contains/**/(pkg_dirs/**/, pkg/*struct pkg*, local*/->dirhash/**/, path/*const char*, local*/)/**//*int*/) {
		if (developer_mode/**/) {
			pkg_emit_error/**/("duplicate directory listing: %s, fatal (developer mode)"/*char[]*/,
					   path/*const char*, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		} else {
			pkg_emit_error/**/("duplicate directory listing: %s, ignoring"/*char[]*/,
					   path/*const char*, local*/)/**/;
			return (EPKG_OK/**/)/**/;
		}
	}

	pkg_dir_new/**/(&d/*struct pkg_dir*, local*//*struct pkg_dir***/)/**/;
	strlcpy/**/(d/*struct pkg_dir*, local*/->path/**/,
		    path/*const char*, local*/,
		    sizeof(d/*struct pkg_dir*, local*/->path/**/)/**//*size_t*/)/**/;

	if (uname/*const char*, local*/ != NULL/*void**//*int*/)
		strlcpy/**/(d/*struct pkg_dir*, local*/->uname/**/,
			    uname/*const char*, local*/,
			    sizeof(d/*struct pkg_dir*, local*/->uname/**/)/**//*size_t*/)/**/;

	if (gname/*const char*, local*/ != NULL/*void**//*int*/)
		strlcpy/**/(d/*struct pkg_dir*, local*/->gname/**/,
			    gname/*const char*, local*/,
			    sizeof(d/*struct pkg_dir*, local*/->gname/**/)/**//*size_t*/)/**/;

	if (perm/*mode_t, local*/ != 0/*int*//*int*/)
		d/*struct pkg_dir*, local*/->perm/**/ = perm/*mode_t, local*//*mode_t, local*/;

	if (fflags/*u_long, local*/ != 0/*int*//*int*/)
		d/*struct pkg_dir*, local*/->fflags/**/ = fflags/*u_long, local*//*u_long, local*/;

	kh_safe_add/**/(pkg_dirs/**/, pkg/*struct pkg*, local*/->dirhash/**/,
			d/*struct pkg_dir*, local*/,
			d/*struct pkg_dir*, local*/->path/**/)/**/;
	LL_APPEND/**/(pkg/*struct pkg*, local*/->dirs/**/,
		      d/*struct pkg_dir*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addscript(struct pkg *pkg, const char *data, pkg_script type)
{

	assert(pkg != NULL);
	utstring_renew(pkg->scripts[type]);
	utstring_printf(pkg->scripts[type], "%s", data);

	return (EPKG_OK);
}

int
pkg_addscript_fileat(int fd, struct pkg *pkg, const char *filename)
{
	char *data;
	pkg_script type;
	int ret = EPKG_OK;
	off_t sz = 0;

	assert(pkg != NULL);
	assert(filename != NULL);

	pkg_debug(1, "Adding script from: '%s'", filename);

	if ((ret = file_to_bufferat(fd, filename, &data, &sz)) != EPKG_OK)
		return (ret);

	if (strcmp(filename, "pkg-pre-install") == 0 ||
			strcmp(filename, "+PRE_INSTALL") == 0) {
		type = PKG_SCRIPT_PRE_INSTALL;
	} else if (strcmp(filename, "pkg-post-install") == 0 ||
			strcmp(filename, "+POST_INSTALL") == 0) {
		type = PKG_SCRIPT_POST_INSTALL;
	} else if (strcmp(filename, "pkg-install") == 0 ||
			strcmp(filename, "+INSTALL") == 0) {
		type = PKG_SCRIPT_INSTALL;
	} else if (strcmp(filename, "pkg-pre-deinstall") == 0 ||
			strcmp(filename, "+PRE_DEINSTALL") == 0) {
		type = PKG_SCRIPT_PRE_DEINSTALL;
	} else if (strcmp(filename, "pkg-post-deinstall") == 0 ||
			strcmp(filename, "+POST_DEINSTALL") == 0) {
		type = PKG_SCRIPT_POST_DEINSTALL;
	} else if (strcmp(filename, "pkg-deinstall") == 0 ||
			strcmp(filename, "+DEINSTALL") == 0) {
		type = PKG_SCRIPT_DEINSTALL;
	} else if (strcmp(filename, "pkg-pre-upgrade") == 0 ||
			strcmp(filename, "+PRE_UPGRADE") == 0) {
		type = PKG_SCRIPT_PRE_UPGRADE;
	} else if (strcmp(filename, "pkg-post-upgrade") == 0 ||
			strcmp(filename, "+POST_UPGRADE") == 0) {
		type = PKG_SCRIPT_POST_UPGRADE;
	} else if (strcmp(filename, "pkg-upgrade") == 0 ||
			strcmp(filename, "+UPGRADE") == 0) {
		type = PKG_SCRIPT_UPGRADE;
	} else {
		pkg_emit_error("unknown script '%s'", filename);
		ret = EPKG_FATAL;
		goto cleanup;
	}

	ret = pkg_addscript(pkg, data, type);
cleanup:
	free(data);
	return (ret);
}

int
pkg_addscript_file(struct pkg *pkg, const char *path)
{
	char *filename;
	char *data;
	pkg_script type;
	int ret = EPKG_OK;
	off_t sz = 0;

	assert(pkg != NULL);
	assert(path != NULL);

	pkg_debug(1, "Adding script from: '%s'", path);

	if ((ret = file_to_buffer(path, &data, &sz)) != EPKG_OK)
		return (ret);

	filename = strrchr(path, '/');
	filename[0] = '\0';
	filename++;

	if (strcmp(filename, "pkg-pre-install") == 0 ||
			strcmp(filename, "+PRE_INSTALL") == 0) {
		type = PKG_SCRIPT_PRE_INSTALL;
	} else if (strcmp(filename, "pkg-post-install") == 0 ||
			strcmp(filename, "+POST_INSTALL") == 0) {
		type = PKG_SCRIPT_POST_INSTALL;
	} else if (strcmp(filename, "pkg-install") == 0 ||
			strcmp(filename, "+INSTALL") == 0) {
		type = PKG_SCRIPT_INSTALL;
	} else if (strcmp(filename, "pkg-pre-deinstall") == 0 ||
			strcmp(filename, "+PRE_DEINSTALL") == 0) {
		type = PKG_SCRIPT_PRE_DEINSTALL;
	} else if (strcmp(filename, "pkg-post-deinstall") == 0 ||
			strcmp(filename, "+POST_DEINSTALL") == 0) {
		type = PKG_SCRIPT_POST_DEINSTALL;
	} else if (strcmp(filename, "pkg-deinstall") == 0 ||
			strcmp(filename, "+DEINSTALL") == 0) {
		type = PKG_SCRIPT_DEINSTALL;
	} else if (strcmp(filename, "pkg-pre-upgrade") == 0 ||
			strcmp(filename, "+PRE_UPGRADE") == 0) {
		type = PKG_SCRIPT_PRE_UPGRADE;
	} else if (strcmp(filename, "pkg-post-upgrade") == 0 ||
			strcmp(filename, "+POST_UPGRADE") == 0) {
		type = PKG_SCRIPT_POST_UPGRADE;
	} else if (strcmp(filename, "pkg-upgrade") == 0 ||
			strcmp(filename, "+UPGRADE") == 0) {
		type = PKG_SCRIPT_UPGRADE;
	} else {
		pkg_emit_error("unknown script '%s'", filename);
		ret = EPKG_FATAL;
		goto cleanup;
	}

	ret = pkg_addscript(pkg, data, type);
cleanup:
	free(data);
	return (ret);
}

int
pkg_appendscript(struct pkg *pkg, const char *cmd, pkg_script type)
{

	assert(pkg != NULL);
	assert(cmd != NULL && cmd[0] != '\0');

	if (pkg->scripts[type] == NULL)
		utstring_new(pkg->scripts[type]);

	utstring_printf(pkg->scripts[type], "%s", cmd);

	return (EPKG_OK);
}

int
pkg_addoption(struct pkg *pkg, const char *key, const char *value)
{
	struct pkg_option	*o = NULL/*void**/;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(key/*const char*, local*/ != NULL/*void**//*int*/ && key/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;
	assert/**/(value/*const char*, local*/ != NULL/*void**//*int*/ && value/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	/* There might be a default or description for the option
	   already, so we only count it as a duplicate if the value
	   field is already set. Which implies there could be a
	   default value or description for an option but no actual
	   value. */

	pkg_debug/**/(2/*int*/,"Pkg> adding options: %s = %s"/*char[]*/,
		      key/*const char*, local*/, value/*const char*, local*/)/**/;
	HASH_FIND_STR/**/(pkg/*struct pkg*, local*/->options/**/,
			  key/*const char*, local*/,
			  o/*struct pkg_option*, local*/)/**/;
	if (o/*struct pkg_option*, local*/ == NULL/*void**//*int*/) {
		pkg_option_new/**/(&o/*struct pkg_option*, local*//*struct pkg_option***/)/**/;
		o/*struct pkg_option*, local*/->key/**/ = strdup/**/(key/*const char*, local*/)/**//**/;
		if (o/*struct pkg_option*, local*/->key/**/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
	} else if ( o/*struct pkg_option*, local*/->value/**/ != NULL/*void**//*int*/) {
		if (developer_mode/**/) {
			pkg_emit_error/**/("duplicate options listing: %s, fatal (developer mode)"/*char[]*/,
					   key/*const char*, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		} else {
			pkg_emit_error/**/("duplicate options listing: %s, ignoring"/*char[]*/,
					   key/*const char*, local*/)/**/;
			return (EPKG_OK/**/)/**/;
		}
	}

	o/*struct pkg_option*, local*/->value/**/ = strdup/**/(value/*const char*, local*/)/**//**/;
	if (o/*struct pkg_option*, local*/->value/**/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	HASH_ADD_KEYPTR/**/(hh/**/, pkg/*struct pkg*, local*/->options/**/,
			    o/*struct pkg_option*, local*/->key/**/,
			    strlen/**/(o/*struct pkg_option*, local*/->key/**/)/**/,
			    o/*struct pkg_option*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addoption_default(struct pkg *pkg, const char *key,
		      const char *default_value)
{
	struct pkg_option *o = NULL/*void**/;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(key/*const char*, local*/ != NULL/*void**//*int*/ && key/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;
	assert/**/(default_value/*const char*, local*/ != NULL/*void**//*int*/ && default_value/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	/* There might be a value or description for the option
	   already, so we only count it as a duplicate if the
	   default_value field is already set. Which implies there
	   could be a default value or description for an option but
	   no actual value. */

	HASH_FIND_STR/**/(pkg/*struct pkg*, local*/->options/**/,
			  key/*const char*, local*/,
			  o/*struct pkg_option*, local*/)/**/;
	if (o/*struct pkg_option*, local*/ == NULL/*void**//*int*/) {
		pkg_option_new/**/(&o/*struct pkg_option*, local*//*struct pkg_option***/)/**/;
		o/*struct pkg_option*, local*/->key/**/ = strdup/**/(key/*const char*, local*/)/**//**/;
		if (o/*struct pkg_option*, local*/->key/**/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
	} else if ( o/*struct pkg_option*, local*/->default_value/**/ != NULL/*void**//*int*/) {
		if (developer_mode/**/) {
			pkg_emit_error/**/("duplicate default value for option: %s, fatal (developer mode)"/*char[]*/,
					   key/*const char*, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		} else {
			pkg_emit_error/**/("duplicate default value for option: %s, ignoring"/*char[]*/,
					   key/*const char*, local*/)/**/;
			return (EPKG_OK/**/)/**/;
		}
	}

	o/*struct pkg_option*, local*/->default_value/**/ = strdup/**/(default_value/*const char*, local*/)/**//**/;
	if (o/*struct pkg_option*, local*/->default_value/**/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	HASH_ADD_KEYPTR/**/(hh/**/, pkg/*struct pkg*, local*/->options/**/,
			    o/*struct pkg_option*, local*/->default_value/**/,
			    strlen/**/(o/*struct pkg_option*, local*/->default_value/**/)/**/,
			    o/*struct pkg_option*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addoption_description(struct pkg *pkg, const char *key,
			  const char *description)
{
	struct pkg_option *o = NULL/*void**/;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(key/*const char*, local*/ != NULL/*void**//*int*/ && key/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;
	assert/**/(description/*const char*, local*/ != NULL/*void**//*int*/ && description/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	/* There might be a value or default for the option already,
	   so we only count it as a duplicate if the description field
	   is already set. Which implies there could be a default
	   value or description for an option but no actual value. */

	HASH_FIND_STR/**/(pkg/*struct pkg*, local*/->options/**/,
			  key/*const char*, local*/,
			  o/*struct pkg_option*, local*/)/**/;
	if (o/*struct pkg_option*, local*/ == NULL/*void**//*int*/) {
		pkg_option_new/**/(&o/*struct pkg_option*, local*//*struct pkg_option***/)/**/;
		o/*struct pkg_option*, local*/->key/**/ = strdup/**/(key/*const char*, local*/)/**//**/;
		if (o/*struct pkg_option*, local*/->key/**/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
	} else if ( o/*struct pkg_option*, local*/->description/**/ != NULL/*void**//*int*/) {
		if (developer_mode/**/) {
			pkg_emit_error/**/("duplicate description for option: %s, fatal (developer mode)"/*char[]*/,
					   key/*const char*, local*/)/**/;
			return (EPKG_FATAL/**/)/**/;
		} else {
			pkg_emit_error/**/("duplicate description for option: %s, ignoring"/*char[]*/,
					   key/*const char*, local*/)/**/;
			return (EPKG_OK/**/)/**/;
		}
	}

	o/*struct pkg_option*, local*/->description/**/ = strdup/**/(description/*const char*, local*/)/**//**/;
	if (o/*struct pkg_option*, local*/->description/**/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	HASH_ADD_KEYPTR/**/(hh/**/, pkg/*struct pkg*, local*/->options/**/,
			    o/*struct pkg_option*, local*/->description/**/,
			    strlen/**/(o/*struct pkg_option*, local*/->description/**/)/**/,
			    o/*struct pkg_option*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addshlib_required(struct pkg *pkg, const char *name)
{
	char *storename;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(name/*const char*, local*/ != NULL/*void**//*int*/ && name/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	/* silently ignore duplicates in case of shlibs */
	if (kh_contains/**/(strings/**/, pkg/*struct pkg*, local*/->shlibs_required/**/, name/*const char*, local*/)/**/)
		return (EPKG_OK/**/)/**/;

	storename/*char*, local*/ = strdup/**/(name/*const char*, local*/)/**//*char*, local*/;
	if (storename/*char*, local*/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	kh_add/**/(strings/**/,
		   pkg/*struct pkg*, local*/->shlibs_required/**/,
		   storename/*char*, local*/, storename/*char*, local*/,
		   free/**/)/**/;

	pkg_debug/**/(3/*int*/, "added shlib deps for %s on %s"/*char[]*/,
		      pkg/*struct pkg*, local*/->name/**/,
		      name/*const char*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addshlib_provided(struct pkg *pkg, const char *name)
{
	char *storename;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(name/*const char*, local*/ != NULL/*void**//*int*/ && name/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	/* ignore files which are not starting with lib */
	if (strncmp/**/(name/*const char*, local*/, "lib"/*char[]*/, 3/*int*/)/**/ != 0/*int*//*int*/)
		return (EPKG_OK/**/)/**/;

	/* silently ignore duplicates in case of shlibs */
	if (kh_contains/**/(strings/**/, pkg/*struct pkg*, local*/->shlibs_provided/**/, name/*const char*, local*/)/**/)
		return (EPKG_OK/**/)/**/;

	storename/*char*, local*/ = strdup/**/(name/*const char*, local*/)/**//*char*, local*/;
	if (storename/*char*, local*/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	kh_add/**/(strings/**/,
		   pkg/*struct pkg*, local*/->shlibs_provided/**/,
		   storename/*char*, local*/, storename/*char*, local*/,
		   free/**/)/**/;

	pkg_debug/**/(3/*int*/, "added shlib provide %s for %s"/*char[]*/,
		      name/*const char*, local*/,
		      pkg/*struct pkg*, local*/->name/**/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addconflict(struct pkg *pkg, const char *uniqueid)
{
	struct pkg_conflict *c = NULL/*void**/;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(uniqueid/*const char*, local*/ != NULL/*void**//*int*/ && uniqueid/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	HASH_FIND_STR/**/(pkg/*struct pkg*, local*/->conflicts/**/,
			  __DECONST/**/(char *, uniqueid/*const char*, local*/)/**/,
			  c/*struct pkg_conflict*, local*/)/**/;
	/* silently ignore duplicates in case of conflicts */
	if (c/*struct pkg_conflict*, local*/ != NULL/*void**//*int*/)
		return (EPKG_OK/**/)/**/;

	pkg_conflict_new/**/(&c/*struct pkg_conflict*, local*//*struct pkg_conflict***/)/**/;
	c/*struct pkg_conflict*, local*/->uid/**/ = strdup/**/(uniqueid/*const char*, local*/)/**//**/;
	if (c/*struct pkg_conflict*, local*/->uid/**/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}
	pkg_debug/**/(3/*int*/, "Pkg: add a new conflict origin: %s, with %s"/*char[]*/,
		      pkg/*struct pkg*, local*/->uid/**/,
		      uniqueid/*const char*, local*/)/**/;

	HASH_ADD_KEYPTR/**/(hh/**/, pkg/*struct pkg*, local*/->conflicts/**/,
			    c/*struct pkg_conflict*, local*/->uid/**/,
			    strlen/**/(c/*struct pkg_conflict*, local*/->uid/**/)/**/,
			    c/*struct pkg_conflict*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addrequire(struct pkg *pkg, const char *name)
{
	char *storename;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(name/*const char*, local*/ != NULL/*void**//*int*/ && name/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	/* silently ignore duplicates in case of conflicts */
	if (kh_contains/**/(strings/**/, pkg/*struct pkg*, local*/->requires/**/, name/*const char*, local*/)/**/)
		return (EPKG_OK/**/)/**/;

	storename/*char*, local*/ = strdup/**/(name/*const char*, local*/)/**//*char*, local*/;
	if (storename/*char*, local*/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	kh_add/**/(strings/**/, pkg/*struct pkg*, local*/->requires/**/,
		   storename/*char*, local*/, storename/*char*, local*/,
		   free/**/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_addprovide(struct pkg *pkg, const char *name)
{
	char *storename;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(name/*const char*, local*/ != NULL/*void**//*int*/ && name/*const char*, local*/[0/*int*/]/*const char*/ != '\0'/*char*//*int*//*int*/)/**/;

	/* silently ignore duplicates in case of conflicts */
	if (kh_contains/**/(strings/**/, pkg/*struct pkg*, local*/->provides/**/, name/*const char*, local*/)/**/)
		return (EPKG_OK/**/)/**/;

	storename/*char*, local*/ = strdup/**/(name/*const char*, local*/)/**//*char*, local*/;
	if (storename/*char*, local*/ == NULL/*void**//*int*/) {
		pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
		return (EPKG_FATAL/**/)/**/;
	}

	kh_add/**/(strings/**/, pkg/*struct pkg*, local*/->provides/**/,
		   storename/*char*, local*/, storename/*char*, local*/,
		   free/**/)/**/;

	return (EPKG_OK/**/)/**/;
}

const char *
pkg_kv_get(struct pkg_kv *const *kv, const char *tag)
{
	struct pkg_kv *k;

	assert/**/(tag/*const char*, local*/ != NULL/*void**//*int*/)/**/;

	LL_FOREACH(*kv/*struct pkg_kv*const*, local*//*struct pkg_kv**/,
		   k/*struct pkg_kv*, local*/) {
		if (strcmp/**/(k/*struct pkg_kv*, local*/->key/**/, tag/*const char*, local*/)/**/ == 0/*int*//*int*/)
			return (k/*struct pkg_kv*, local*/->value/**/)/**/;
	}

	return (NULL/*void**/)/*void**/;
}

int
pkg_kv_add(struct pkg_kv **list, const char *key, const char *val, const char *title)
{
	struct pkg_kv *kv;

	assert/**/(val/*const char*, local*/ != NULL/*void**//*int*/)/**/;
	assert/**/(title/*const char*, local*/ != NULL/*void**//*int*/)/**/;

	LL_FOREACH(*list/*struct pkg_kv**, local*//*struct pkg_kv**/,
		   kv/*struct pkg_kv*, local*/) {
		if (strcmp/**/(kv/*struct pkg_kv*, local*/->key/**/, key/*const char*, local*/)/**/ == 0/*int*//*int*/) {
			if (developer_mode/**/) {
				pkg_emit_error/**/("duplicate %s: %s, fatal"
				    " (developer mode)"/*char[]*/,
				    title/*const char*, local*/,
				    key/*const char*, local*/)/**/;
				return (EPKG_FATAL/**/)/**/;
			} else {
				pkg_emit_error/**/("duplicate %s: %s, "
				    "ignoring"/*char[]*/,
				    title/*const char*, local*/,
				    val/*const char*, local*/)/**/;
				return (EPKG_OK/**/)/**/;
			}
		}
	}

	pkg_kv_new/**/(&kv/*struct pkg_kv*, local*//*struct pkg_kv***/,
		       key/*const char*, local*/, val/*const char*, local*/)/**/;
	LL_APPEND/**/(*list/*struct pkg_kv**, local*//*struct pkg_kv**/,
		      kv/*struct pkg_kv*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_list_count(const struct pkg *pkg, pkg_list list)
{
	switch (list/*pkg_list, local*/) {
	case PKG_DEPS/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->depshash/**/)/**/)/**/;
	case PKG_RDEPS/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->rdepshash/**/)/**/)/**/;
	case PKG_OPTIONS/**/:
		return (HASH_COUNT/**/(pkg/*const struct pkg*, local*/->options/**/)/**/)/**/;
	case PKG_FILES/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->filehash/**/)/**/)/**/;
	case PKG_DIRS/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->dirhash/**/)/**/)/**/;
	case PKG_USERS/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->users/**/)/**/)/**/;
	case PKG_GROUPS/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->groups/**/)/**/)/**/;
	case PKG_SHLIBS_REQUIRED/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->shlibs_required/**/)/**/)/**/;
	case PKG_SHLIBS_PROVIDED/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->shlibs_provided/**/)/**/)/**/;
	case PKG_CONFLICTS/**/:
		return (HASH_COUNT/**/(pkg/*const struct pkg*, local*/->conflicts/**/)/**/)/**/;
	case PKG_PROVIDES/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->provides/**/)/**/)/**/;
	case PKG_REQUIRES/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->requires/**/)/**/)/**/;
	case PKG_CONFIG_FILES/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->config_files/**/)/**/)/**/;
	case PKG_CATEGORIES/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->categories/**/)/**/)/**/;
	case PKG_LICENSES/**/:
		return (kh_count/**/(pkg/*const struct pkg*, local*/->licenses/**/)/**/)/**/;
	}
	
	return (0/*int*/)/*int*/;
}

void
pkg_list_free(struct pkg *pkg, pkg_list list)  {
	switch (list/*pkg_list, local*/) {
	case PKG_DEPS/**/:
		LL_FREE/**/(pkg/*struct pkg*, local*/->depends/**/,
			    pkg_dep_free/**/)/**/;
		kh_destroy_pkg_deps/**/(pkg/*struct pkg*, local*/->depshash/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_DEPS/**//**//**/;
		break;
	case PKG_RDEPS/**/:
		LL_FREE/**/(pkg/*struct pkg*, local*/->rdepends/**/,
			    pkg_dep_free/**/)/**/;
		kh_destroy_pkg_deps/**/(pkg/*struct pkg*, local*/->rdepshash/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_RDEPS/**//**//**/;
		break;
	case PKG_OPTIONS/**/:
		HASH_FREE/**/(pkg/*struct pkg*, local*/->options/**/,
			      pkg_option_free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_OPTIONS/**//**//**/;
		break;
	case PKG_FILES/**/:
	case PKG_CONFIG_FILES/**/:
		LL_FREE/**/(pkg/*struct pkg*, local*/->files/**/,
			    pkg_file_free/**/)/**/;
		kh_destroy_pkg_files/**/(pkg/*struct pkg*, local*/->filehash/**/)/**/;
		kh_free/**/(pkg_config_files/**/,
			    pkg/*struct pkg*, local*/->config_files/**/,
			    struct pkg_config_file, pkg_config_file_free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_FILES/**//**//**/;
		break;
	case PKG_DIRS/**/:
		LL_FREE/**/(pkg/*struct pkg*, local*/->dirs/**/,
			    pkg_dir_free/**/)/**/;
		kh_destroy_pkg_dirs/**/(pkg/*struct pkg*, local*/->dirhash/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_DIRS/**//**//**/;
		break;
	case PKG_USERS/**/:
		kh_free/**/(strings/**/, pkg/*struct pkg*, local*/->users/**/,
			    char, free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_USERS/**//**//**/;
		break;
	case PKG_GROUPS/**/:
		kh_free/**/(strings/**/,
			    pkg/*struct pkg*, local*/->groups/**/, char,
			    free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_GROUPS/**//**//**/;
		break;
	case PKG_SHLIBS_REQUIRED/**/:
		kh_free/**/(strings/**/,
			    pkg/*struct pkg*, local*/->shlibs_required/**/,
			    char, free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_SHLIBS_REQUIRED/**//**//**/;
		break;
	case PKG_SHLIBS_PROVIDED/**/:
		kh_free/**/(strings/**/,
			    pkg/*struct pkg*, local*/->shlibs_provided/**/,
			    char, free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_SHLIBS_PROVIDED/**//**//**/;
		break;
	case PKG_CONFLICTS/**/:
		HASH_FREE/**/(pkg/*struct pkg*, local*/->conflicts/**/,
			      pkg_conflict_free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_CONFLICTS/**//**//**/;
		break;
	case PKG_PROVIDES/**/:
		kh_free/**/(strings/**/,
			    pkg/*struct pkg*, local*/->provides/**/, char,
			    free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_PROVIDES/**//**//**/;
		break;
	case PKG_REQUIRES/**/:
		kh_free/**/(strings/**/,
			    pkg/*struct pkg*, local*/->requires/**/, char,
			    free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_REQUIRES/**//**//**/;
		break;
	case PKG_CATEGORIES/**/:
		kh_free/**/(strings/**/,
			    pkg/*struct pkg*, local*/->categories/**/, char,
			    free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_CATEGORIES/**//**//**/;
		break;
	case PKG_LICENSES/**/:
		kh_free/**/(strings/**/,
			    pkg/*struct pkg*, local*/->licenses/**/, char,
			    free/**/)/**/;
		pkg/*struct pkg*, local*/->flags/**/ &= ~PKG_LOAD_LICENSES/**//**//**/;
		break;
	}
}

int
pkg_open(struct pkg **pkg_p, const char *path, struct pkg_manifest_key *keys, int flags)
{
	struct archive *a;
	struct archive_entry *ae;
	int ret;

	ret/*int, local*/ = pkg_open2/**/(pkg_p/*struct pkg**, local*/,
					  &a/*struct archive*, local*//*struct archive***/,
					  &ae/*struct archive_entry*, local*//*struct archive_entry***/,
					  path/*const char*, local*/,
					  keys/*struct pkg_manifest_key*, local*/,
					  flags/*int, local*/,
					  -1/*int*//*int*/)/**//*int, local*/;

	if (ret/*int, local*/ != EPKG_OK/**//*int*/ && ret/*int, local*/ != EPKG_END/**//*int*//*int*/)
		return (EPKG_FATAL/**/)/**/;

	archive_read_close/**/(a/*struct archive*, local*/)/**/;
	archive_read_free/**/(a/*struct archive*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_open_fd(struct pkg **pkg_p, int fd, struct pkg_manifest_key *keys, int flags)
{
	struct archive *a;
	struct archive_entry *ae;
	int ret;

	ret/*int, local*/ = pkg_open2/**/(pkg_p/*struct pkg**, local*/,
					  &a/*struct archive*, local*//*struct archive***/,
					  &ae/*struct archive_entry*, local*//*struct archive_entry***/,
					  NULL/*void**/,
					  keys/*struct pkg_manifest_key*, local*/,
					  flags/*int, local*/,
					  fd/*int, local*/)/**//*int, local*/;

	if (ret/*int, local*/ != EPKG_OK/**//*int*/ && ret/*int, local*/ != EPKG_END/**//*int*//*int*/)
		return (EPKG_FATAL/**/)/**/;

	archive_read_close/**/(a/*struct archive*, local*/)/**/;
	archive_read_free/**/(a/*struct archive*, local*/)/**/;

	return (EPKG_OK/**/)/**/;
}

int
pkg_open2(struct pkg **pkg_p, struct archive **a, struct archive_entry **ae,
    const char *path, struct pkg_manifest_key *keys, int flags, int fd)
{
	struct pkg	*pkg = NULL/*void**/;
	pkg_error_t	 retcode = EPKG_OK/**/;
	int		 ret;
	const char	*fpath;
	bool		 manifest = false/**/;
	bool		 read_from_stdin = 0/*int*/;

	*a/*struct archive**, local*//*struct archive**/ = archive_read_new/**/()/**//*struct archive**/;
	archive_read_support_filter_all/**/(*a/*struct archive**, local*//*struct archive**/)/**/;
	archive_read_support_format_tar/**/(*a/*struct archive**, local*//*struct archive**/)/**/;

	/* archive_read_open_filename() treats a path of NULL as
	 * meaning "read from stdin," but we want this behaviour if
	 * path is exactly "-". In the unlikely event of wanting to
	 * read an on-disk file called "-", just say "./-" or some
	 * other leading path. */

	if (fd/*int, local*/ == -1/*int*//*int*//*int*/) {
		read_from_stdin/*bool, local*/ = (strncmp/**/(path/*const char*, local*/, "-"/*char[]*/, 2/*int*/)/**/ == 0/*int*//*int*/)/*int*//*bool, local*/;

		if (archive_read_open_filename/**/(*a/*struct archive**, local*//*struct archive**/,
						   read_from_stdin/*bool, local*/ ? NULL/*void**/ : path/*const char*, local*//*const char*, local*/, 4096/*int*/)/**/ != ARCHIVE_OK/**//*int*/) {
			if ((flags/*int, local*/ & PKG_OPEN_TRY/**//*int*/)/*int*/ == 0/*int*//*int*/)
				pkg_emit_error/**/("archive_read_open_filename(%s): %s"/*char[]*/,
						   path/*const char*, local*/,
						   archive_error_string/**/(*a/*struct archive**, local*//*struct archive**/)/**/)/**/;

			retcode/*pkg_error_t, local*/ = EPKG_FATAL/**//*pkg_error_t, local*/;
			goto cleanup;
		}
	} else {
		if (archive_read_open_fd/**/(*a/*struct archive**, local*//*struct archive**/, fd/*int, local*/, 4096/*int*/)/**/ != ARCHIVE_OK/**//*int*/) {
			if ((flags/*int, local*/ & PKG_OPEN_TRY/**//*int*/)/*int*/ == 0/*int*//*int*/)
				pkg_emit_error/**/("archive_read_open_fd: %s"/*char[]*/,
					archive_error_string/**/(*a/*struct archive**, local*//*struct archive**/)/**/)/**/;

			retcode/*pkg_error_t, local*/ = EPKG_FATAL/**//*pkg_error_t, local*/;
			goto cleanup;
		}
	}

	retcode/*pkg_error_t, local*/ = pkg_new/*int(struct pkg**pkg pkg_t type)*/(pkg_p/*struct pkg**, local*/,
										   PKG_FILE/**/)/*int*//*pkg_error_t, local*/;
	if (retcode/*pkg_error_t, local*/ != EPKG_OK/**//*int*/)
		goto cleanup;

	pkg/*struct pkg*, local*/ = *pkg_p/*struct pkg**, local*//*struct pkg**//*struct pkg*, local*/;

	while ((ret/*int, local*/ = archive_read_next_header/**/(*a/*struct archive**, local*//*struct archive**/, ae/*struct archive_entry**, local*/)/**//*int, local*/)/*int, local*/ == ARCHIVE_OK/**//*int*/) {
		fpath/*const char*, local*/ = archive_entry_pathname/**/(*ae/*struct archive_entry**, local*//*struct archive_entry**/)/**//*const char*, local*/;
		if (fpath/*const char*, local*/[0/*int*/]/*const char*/ != '+'/*char*//*int*/)
			break;

		if (!manifest/*bool, local*//*int*/ &&
			(flags/*int, local*/ & PKG_OPEN_MANIFEST_COMPACT/**//*int*/)/*int*//*int*/ &&
			strcmp/**/(fpath/*const char*, local*/, "+COMPACT_MANIFEST"/*char[]*/)/**/ == 0/*int*//*int*//*int*/) {
			char *buffer;
			manifest/*bool, local*/ = true/**//*bool, local*/;

			size_t len = archive_entry_size/**/(*ae/*struct archive_entry**, local*//*struct archive_entry**/)/**/;
			buffer/*char*, local*/ = malloc/**/(len/*size_t, local*/)/**//*char*, local*/;
			if (buffer/*char*, local*/ == NULL/*void**//*int*/) {
				pkg_emit_errno/**/("malloc"/*char[]*/, __func__/**/)/**/;
				retcode/*pkg_error_t, local*/ = EPKG_FATAL/**//*pkg_error_t, local*/;
				/* Allow for archive handle to close. */
				goto cleanup;
			}
			archive_read_data/**/(*a/*struct archive**, local*//*struct archive**/,
					      buffer/*char*, local*/,
					      archive_entry_size/**/(*ae/*struct archive_entry**, local*//*struct archive_entry**/)/**/)/**/;
			ret/*int, local*/ = pkg_parse_manifest/**/(pkg/*struct pkg*, local*/,
								   buffer/*char*, local*/,
								   len/*size_t, local*/,
								   keys/*struct pkg_manifest_key*, local*/)/**//*int, local*/;
			free/**/(buffer/*char*, local*/)/**/;
			if (ret/*int, local*/ != EPKG_OK/**//*int*/) {
				retcode/*pkg_error_t, local*/ = EPKG_FATAL/**//*pkg_error_t, local*/;
				goto cleanup;
			}
			/* Do not read anything more */
			break;
		}
		if (!manifest/*bool, local*//*int*/ && strcmp/**/(fpath/*const char*, local*/, "+MANIFEST"/*char[]*/)/**/ == 0/*int*//*int*//*int*/) {
			manifest/*bool, local*/ = true/**//*bool, local*/;
			char *buffer;

			size_t len = archive_entry_size/**/(*ae/*struct archive_entry**, local*//*struct archive_entry**/)/**/;
			buffer/*char*, local*/ = malloc/**/(len/*size_t, local*/)/**//*char*, local*/;
			if (buffer/*char*, local*/ == NULL/*void**//*int*/) {
				pkg_emit_errno/**/("malloc"/*char[]*/, __func__/**/)/**/;
				retcode/*pkg_error_t, local*/ = EPKG_FATAL/**//*pkg_error_t, local*/;
				/* Allow for archive handle to close. */
				goto cleanup;
			}
			archive_read_data/**/(*a/*struct archive**, local*//*struct archive**/,
					      buffer/*char*, local*/,
					      archive_entry_size/**/(*ae/*struct archive_entry**, local*//*struct archive_entry**/)/**/)/**/;
			ret/*int, local*/ = pkg_parse_manifest/**/(pkg/*struct pkg*, local*/,
								   buffer/*char*, local*/,
								   len/*size_t, local*/,
								   keys/*struct pkg_manifest_key*, local*/)/**//*int, local*/;
			free/**/(buffer/*char*, local*/)/**/;
			if (ret/*int, local*/ != EPKG_OK/**//*int*/) {
				if ((flags/*int, local*/ & PKG_OPEN_TRY/**//*int*/)/*int*/ == 0/*int*//*int*/)
					pkg_emit_error/**/("%s is not a valid package: "
						"Invalid manifest"/*char[]*/,
						path/*const char*, local*/)/**/;

				retcode/*pkg_error_t, local*/ = EPKG_FATAL/**//*pkg_error_t, local*/;
				goto cleanup;
			}

			if (flags/*int, local*/ & PKG_OPEN_MANIFEST_ONLY/**//*int*/)
				break;
		}
	}

	if (ret/*int, local*/ != ARCHIVE_OK/**//*int*/ && ret/*int, local*/ != ARCHIVE_EOF/**//*int*//*int*/) {
		if ((flags/*int, local*/ & PKG_OPEN_TRY/**//*int*/)/*int*/ == 0/*int*//*int*/)
			pkg_emit_error/**/("archive_read_next_header(): %s"/*char[]*/,
				archive_error_string/**/(*a/*struct archive**, local*//*struct archive**/)/**/)/**/;

		retcode/*pkg_error_t, local*/ = EPKG_FATAL/**//*pkg_error_t, local*/;
	}

	if (ret/*int, local*/ == ARCHIVE_EOF/**//*int*/)
		retcode/*pkg_error_t, local*/ = EPKG_END/**//*pkg_error_t, local*/;

	if (!manifest/*bool, local*//*int*/) {
		retcode/*pkg_error_t, local*/ = EPKG_FATAL/**//*pkg_error_t, local*/;
		if ((flags/*int, local*/ & PKG_OPEN_TRY/**//*int*/)/*int*/ == 0/*int*//*int*/)
			pkg_emit_error/**/("%s is not a valid package: no manifest found"/*char[]*/,
					   path/*const char*, local*/)/**/;
	}

	cleanup:
	if (retcode/*pkg_error_t, local*/ != EPKG_OK/**//*int*/ && retcode/*pkg_error_t, local*/ != EPKG_END/**//*int*//*int*/) {
		if (*a/*struct archive**, local*//*struct archive**/ != NULL/*void**//*int*/) {
			archive_read_close/**/(*a/*struct archive**, local*//*struct archive**/)/**/;
			archive_read_free/**/(*a/*struct archive**, local*//*struct archive**/)/**/;
		}
		free/**/(pkg/*struct pkg*, local*/)/**/;
		*pkg_p/*struct pkg**, local*//*struct pkg**/ = NULL/*void**//*struct pkg**/;
		*a/*struct archive**, local*//*struct archive**/ = NULL/*void**//*struct archive**/;
		*ae/*struct archive_entry**, local*//*struct archive_entry**/ = NULL/*void**//*struct archive_entry**/;
	}

	return (retcode/*pkg_error_t, local*/)/*pkg_error_t, local*/;
}

int
pkg_validate(struct pkg *pkg, struct pkgdb *db)
{
	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;
	unsigned flags = PKG_LOAD_BASIC/**/|PKG_LOAD_OPTIONS/**//**/|PKG_LOAD_DEPS/**//**/|
					PKG_LOAD_REQUIRES/**//**/|PKG_LOAD_PROVIDES/**//**/|
					PKG_LOAD_SHLIBS_REQUIRED/**//**/|PKG_LOAD_SHLIBS_PROVIDED/**//**/|
					PKG_LOAD_ANNOTATIONS/**//**/|PKG_LOAD_CONFLICTS/**//**/;

	if (pkg/*struct pkg*, local*/->uid/**/ == NULL/*void**//*int*/) {
		/* Keep that part for the day we have to change it */
		/* Generate uid from name*/
		if (pkg/*struct pkg*, local*/->name/**/ == NULL/*void**//*int*/)
			return (EPKG_FATAL/**/)/**/;

		pkg/*struct pkg*, local*/->uid/**/ = strdup/**/(pkg/*struct pkg*, local*/->name/**/)/**//**/;
		if (pkg/*struct pkg*, local*/->uid/**/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
	}

	if (pkg/*struct pkg*, local*/->digest/**/ == NULL/*void**//*int*/ || !pkg_checksum_is_valid/**/(pkg/*struct pkg*, local*/->digest/**/,
													strlen/**/(pkg/*struct pkg*, local*/->digest/**/)/**/)/**//*int*//*int*/) {
		/* Calculate new digest */
		if (pkgdb_ensure_loaded/**/(db/*struct pkgdb*, local*/, pkg/*struct pkg*, local*/, flags/*unsigned, local*/)/**/) {
			return (pkg_checksum_calculate/**/(pkg/*struct pkg*, local*/, db/*struct pkgdb*, local*/)/**/)/**/;
		}
		return (EPKG_FATAL/**/)/**/;
	}

	return (EPKG_OK/**/)/**/;
}

int
pkg_test_filesum(struct pkg *pkg)
{
	struct pkg_file *f = NULL/*void**/;
	int rc = EPKG_OK/**/;
	int ret;

	assert/**/(pkg/*struct pkg*, local*/ != NULL/*void**//*int*/)/**/;

	while (pkg_files/**/(pkg/*struct pkg*, local*/, &f/*struct pkg_file*, local*//*struct pkg_file***/)/**/ == EPKG_OK/**//*int*/) {
		if (f/*struct pkg_file*, local*/->sum/**/ != NULL/*void**//*int*/) {
			ret/*int, local*/ = pkg_checksum_validate_file/**/(f/*struct pkg_file*, local*/->path/**/,
									   f/*struct pkg_file*, local*/->sum/**/)/**//*int, local*/;
			if (ret/*int, local*/ != 0/*int*//*int*/) {
				if (ret/*int, local*/ == ENOENT/**//*int*/)
					pkg_emit_file_missing/**/(pkg/*struct pkg*, local*/,
								  f/*struct pkg_file*, local*/)/**/;
				else
					pkg_emit_file_mismatch/**/(pkg/*struct pkg*, local*/,
								   f/*struct pkg_file*, local*/,
								   f/*struct pkg_file*, local*/->sum/**/)/**/;
				rc/*int, local*/ = EPKG_FATAL/**//*int, local*/;
			}
		}
	}

	return (rc/*int, local*/)/*int, local*/;
}

int
pkg_recompute(struct pkgdb *db, struct pkg *pkg)
{
	struct pkg_file *f = NULL/*void**/;
	hardlinks_t *hl = NULL/*void**/;
	int64_t flatsize = 0/*int*/;
	struct stat st;
	bool regular = false/**/;
	char *sum;
	int rc = EPKG_OK/**/;

	hl/*hardlinks_t*, local*/ = kh_init_hardlinks/**/()/**//*hardlinks_t*, local*/;
	while (pkg_files/**/(pkg/*struct pkg*, local*/, &f/*struct pkg_file*, local*//*struct pkg_file***/)/**/ == EPKG_OK/**//*int*/) {
		if (lstat/**/(f/*struct pkg_file*, local*/->path/**/, &st/*struct stat, local*//*struct stat**/)/**/ == 0/*int*//*int*/) {
			regular/*bool, local*/ = true/**//*bool, local*/;
			sum/*char*, local*/ = pkg_checksum_generate_file/**/(f/*struct pkg_file*, local*/->path/**/,
									     PKG_HASH_TYPE_SHA256_HEX/**/)/**//*char*, local*/;

			if (S_ISLNK/**/(st/*struct stat, local*/.st_mode/**/)/**/)
				regular/*bool, local*/ = false/**//*bool, local*/;

			if (sum/*char*, local*/ == NULL/*void**//*int*/) {
				rc/*int, local*/ = EPKG_FATAL/**//*int, local*/;
				break;
			}

			if (st/*struct stat, local*/.st_nlink/**/ > 1/*int*//*int*/)
				regular/*bool, local*/ = !check_for_hardlink/**/(hl/*hardlinks_t*, local*/,
										 &st/*struct stat, local*//*struct stat**/)/**//*int*//*bool, local*/;

			if (regular/*bool, local*/)
				flatsize/*int64_t, local*/ += st/*struct stat, local*/.st_size/**//*int64_t, local*/;
		
			if (strcmp/**/(sum/*char*, local*/, f/*struct pkg_file*, local*/->sum/**/)/**/ != 0/*int*//*int*/)
				pkgdb_file_set_cksum/**/(db/*struct pkgdb*, local*/,
							 f/*struct pkg_file*, local*/,
							 sum/*char*, local*/)/**/;
			free/**/(sum/*char*, local*/)/**/;
		}
	}
	kh_destroy_hardlinks/**/(hl/*hardlinks_t*, local*/)/**/;

	if (flatsize/*int64_t, local*/ != pkg/*struct pkg*, local*/->flatsize/**//*int*/)
		pkg/*struct pkg*, local*/->flatsize/**/ = flatsize/*int64_t, local*//*int64_t, local*/;

	return (rc/*int, local*/)/*int, local*/;
}

int
pkg_try_installed(struct pkgdb *db, const char *name,
		struct pkg **pkg, unsigned flags) {
	struct pkgdb_it *it = NULL/*void**/;
	int ret = EPKG_FATAL/**/;

	if ((it/*struct pkgdb_it*, local*/ = pkgdb_query/**/(db/*struct pkgdb*, local*/, name/*const char*, local*/, MATCH_EXACT/**/)/**//*struct pkgdb_it*, local*/)/*struct pkgdb_it*, local*/ == NULL/*void**//*int*/)
		return (EPKG_FATAL/**/)/**/;

	ret/*int, local*/ = pkgdb_it_next/**/(it/*struct pkgdb_it*, local*/,
					      pkg/*struct pkg**, local*/,
					      flags/*unsigned, local*/)/**//*int, local*/;
	pkgdb_it_free/**/(it/*struct pkgdb_it*, local*/)/**/;

	return (ret/*int, local*/)/*int, local*/;
}

int
pkg_is_installed(struct pkgdb *db, const char *name)
{
	struct pkg *pkg = NULL/*void**/;
	int ret = EPKG_FATAL/**/;

	ret/*int, local*/ = pkg_try_installed/*int(struct pkgdb*db const char*name struct pkg**pkg unsigned flags)*/(db/*struct pkgdb*, local*/,
														     name/*const char*, local*/,
														     &pkg/*struct pkg*, local*//*struct pkg***/,
														     PKG_LOAD_BASIC/**/)/*int*//*int, local*/;
	pkg_free/*void(struct pkg*pkg)*/(pkg/*struct pkg*, local*/)/*void*/;

	return (ret/*int, local*/)/*int, local*/;
}

bool
pkg_need_message(struct pkg *p, struct pkg *old)
{
	bool ret = true/**/;

	if (old/*struct pkg*, local*/ != NULL/*void**//*int*/) {
		if (p/*struct pkg*, local*/->message/**/->maximum_version/**/) {
			ret/*bool, local*/ = (pkg_version_cmp/**/(old/*struct pkg*, local*/->version/**/, p/*struct pkg*, local*/->message/**/->maximum_version/**/)/**/
					      <= 0/*int*//*int*/)/*int*//*bool, local*/;
		}
		if (ret/*bool, local*/ && p/*struct pkg*, local*/->message/**/->minimum_version/**//*int*/) {
			ret/*bool, local*/ = (pkg_version_cmp/**/(old/*struct pkg*, local*/->version/**/, p/*struct pkg*, local*/->message/**/->maximum_version/**/)/**/
								>= 0/*int*//*int*/)/*int*//*bool, local*/;
		}
	}

	return (ret/*bool, local*/)/*bool, local*/;
}

bool
pkg_has_message(struct pkg *p)
{
	return (p/*struct pkg*, local*/->message/**/ != NULL/*void**//*int*/)/*int*/;
}

bool
pkg_is_locked(const struct pkg * restrict p)
{
	assert/**/(p/*const struct pkg*, local*/ != NULL/*void**//*int*/)/**/;

	return (p/*const struct pkg*, local*/->locked/**/)/**/;
}

bool
pkg_is_config_file(struct pkg *p, const char *path,
    const struct pkg_file **file,
    struct pkg_config_file **cfile)
{

	*file/*const struct pkg_file**, local*//*const struct pkg_file**/ = NULL/*void**//*const struct pkg_file**/;
	*cfile/*struct pkg_config_file**, local*//*struct pkg_config_file**/ = NULL/*void**//*struct pkg_config_file**/;

	if (kh_count/**/(p/*struct pkg*, local*/->config_files/**/)/**/ == 0/*int*//*int*/)
		return (false/**/)/**/;

	kh_find/**/(pkg_files/**/, p/*struct pkg*, local*/->filehash/**/,
		    path/*const char*, local*/,
		    *file/*const struct pkg_file**, local*//*const struct pkg_file**/)/**/;
	if (*file/*const struct pkg_file**, local*//*const struct pkg_file**/ == NULL/*void**//*int*/)
		return (false/**/)/**/;

	kh_find/**/(pkg_config_files/**/,
		    p/*struct pkg*, local*/->config_files/**/,
		    path/*const char*, local*/,
		    *cfile/*struct pkg_config_file**, local*//*struct pkg_config_file**/)/**/;
	if (cfile/*struct pkg_config_file**, local*/ == NULL/*void**//*int*/) {
		*file/*const struct pkg_file**, local*//*const struct pkg_file**/ = NULL/*void**//*const struct pkg_file**/;
		return (false/**/)/**/;
	}

	return (true/**/)/**/;
}

struct pkg_dir *
pkg_get_dir(struct pkg *p, const char *path)
{
	struct pkg_dir *d;

	kh_find/**/(pkg_dirs/**/, p/*struct pkg*, local*/->dirhash/**/,
		    path/*const char*, local*/, d/*struct pkg_dir*, local*/)/**/;

	return (d/*struct pkg_dir*, local*/)/*struct pkg_dir*, local*/;
}

struct pkg_file *
pkg_get_file(struct pkg *p, const char *path)
{
	struct pkg_file *f;

	kh_find/**/(pkg_files/**/, p/*struct pkg*, local*/->filehash/**/,
		    path/*const char*, local*/, f/*struct pkg_file*, local*/)/**/;

	return (f/*struct pkg_file*, local*/)/*struct pkg_file*, local*/;
}

bool
pkg_has_file(struct pkg *p, const char *path)
{
	return (kh_contains/**/(pkg_files/**/, p/*struct pkg*, local*/->filehash/**/, path/*const char*, local*/)/**/)/**/;
}

bool
pkg_has_dir(struct pkg *p, const char *path)
{
	return (kh_contains/**/(pkg_dirs/**/, p/*struct pkg*, local*/->dirhash/**/, path/*const char*, local*/)/**/)/**/;
}

int
pkg_open_root_fd(struct pkg *pkg)
{
	const char *path;

	if (pkg/*struct pkg*, local*/->rootfd/**/ != -1/*int*//*int*//*int*/)
		return (EPKG_OK/**/)/**/;

	path/*const char*, local*/ = pkg_kv_get/*const char*(struct pkg_kv*const*kv const char*tag)*/(&pkg/*struct pkg*, local*/->annotations/**//**/,
												      "relocated"/*char[]*/)/*const char**//*const char*, local*/;
	if (path/*const char*, local*/ == NULL/*void**//*int*/) {
#ifdef F_DUPFD_CLOEXEC
		if ((pkg/*struct pkg*, local*/->rootfd/**/ = fcntl/**/(rootfd/**/, F_DUPFD_CLOEXEC/**/, 0/*int*/)/**//**/)/**/ == -1/*int*//*int*//*int*/) {
#else
		if ((pkg->rootfd = dup(rootfd)) == -1 || fcntl(pkg->rootfd, F_SETFD, FD_CLOEXEC) == -1) {
#endif
			pkg_emit_errno/**/("dup2"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
		return (EPKG_OK/**/)/**/;
	}

	pkg_absolutepath/**/(path/*const char*, local*/,
			     pkg/*struct pkg*, local*/->rootpath/**/,
			     sizeof(pkg/*struct pkg*, local*/->rootpath/**/)/**//*size_t*/,
			     false/**/)/**/;

	if ((pkg/*struct pkg*, local*/->rootfd/**/ = openat/**/(rootfd/**/, pkg/*struct pkg*, local*/->rootpath/**/ + 1/*int*//*int*/, O_DIRECTORY/**/|O_CLOEXEC/**//**/)/**//**/)/**/ >= 0/*int*//*int*/ )
		return (EPKG_OK/**/)/**/;

	pkg/*struct pkg*, local*/->rootpath/**/[0/*int*/]/**/ = '\0'/*char*//*char*/;
	pkg_emit_errno/**/("open"/*char[]*/, __func__/**/)/**/;

	return (EPKG_FATAL/**/)/**/;
}

int
pkg_message_from_ucl(struct pkg *pkg, const ucl_object_t *obj)
{
	struct pkg_message *msg = NULL/*void**/;
	const ucl_object_t *elt, *cur;
	ucl_object_iter_t it = NULL/*void**/;

	if (ucl_object_type/**/(obj/*const ucl_object_t*, local*/)/**/ == UCL_STRING/**//*int*/) {
		msg/*struct pkg_message*, local*/ = calloc/**/(1/*int*/,
							       sizeof(*msg/*struct pkg_message*, local*//*struct pkg_message*/)/*struct pkg_message*//*size_t*/)/**//*struct pkg_message*, local*/;

		if (msg/*struct pkg_message*, local*/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("malloc"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
		msg/*struct pkg_message*, local*/->str/**/ = strdup/**/(ucl_object_tostring/**/(obj/*const ucl_object_t*, local*/)/**/)/**//**/;
		if (msg/*struct pkg_message*, local*/->str/**/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
		msg/*struct pkg_message*, local*/->type/**/ = PKG_MESSAGE_ALWAYS/**//**/;
		LL_APPEND/**/(pkg/*struct pkg*, local*/->message/**/,
			      msg/*struct pkg_message*, local*/)/**/;
		return (EPKG_OK/**/)/**/;
	}

	/* New format of pkg message */
	if (ucl_object_type/**/(obj/*const ucl_object_t*, local*/)/**/ != UCL_ARRAY/**//*int*/)
		pkg_emit_error/**/("package message badly formatted, an array was"
		    " expected"/*char[]*/)/**/;

	while ((cur/*const ucl_object_t*, local*/ = ucl_iterate_object/**/(obj/*const ucl_object_t*, local*/, &it/*ucl_object_iter_t, local*//*ucl_object_iter_t**/, true/**/)/**//*const ucl_object_t*, local*/)/*const ucl_object_t*, local*/) {
		elt/*const ucl_object_t*, local*/ = ucl_object_find_key/**/(cur/*const ucl_object_t*, local*/,
									    "message"/*char[]*/)/**//*const ucl_object_t*, local*/;

		if (elt/*const ucl_object_t*, local*/ == NULL/*void**//*int*/ || ucl_object_type/**/(elt/*const ucl_object_t*, local*/)/**/ != UCL_STRING/**//*int*//*int*/) {
			pkg_emit_error/**/("package message lacks 'message' key"
			    " that is required"/*char[]*/)/**/;

			return (EPKG_FATAL/**/)/**/;
		}

		msg/*struct pkg_message*, local*/ = calloc/**/(1/*int*/,
							       sizeof(*msg/*struct pkg_message*, local*//*struct pkg_message*/)/*struct pkg_message*//*size_t*/)/**//*struct pkg_message*, local*/;

		if (msg/*struct pkg_message*, local*/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("malloc"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}

		msg/*struct pkg_message*, local*/->str/**/ = strdup/**/(ucl_object_tostring/**/(elt/*const ucl_object_t*, local*/)/**/)/**//**/;
		if (msg/*struct pkg_message*, local*/->str/**/ == NULL/*void**//*int*/) {
			pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
			return (EPKG_FATAL/**/)/**/;
		}
		msg/*struct pkg_message*, local*/->type/**/ = PKG_MESSAGE_ALWAYS/**//**/;
		elt/*const ucl_object_t*, local*/ = ucl_object_find_key/**/(cur/*const ucl_object_t*, local*/,
									    "type"/*char[]*/)/**//*const ucl_object_t*, local*/;
		if (elt/*const ucl_object_t*, local*/ != NULL/*void**//*int*/ && ucl_object_type/**/(elt/*const ucl_object_t*, local*/)/**/ == UCL_STRING/**//*int*//*int*/) {
			if (strcasecmp/**/(ucl_object_tostring/**/(elt/*const ucl_object_t*, local*/)/**/, "install"/*char[]*/)/**/ == 0/*int*//*int*/)
				msg/*struct pkg_message*, local*/->type/**/ = PKG_MESSAGE_INSTALL/**//**/;
			else if (strcasecmp/**/(ucl_object_tostring/**/(elt/*const ucl_object_t*, local*/)/**/, "remove"/*char[]*/)/**/ == 0/*int*//*int*/)
				msg/*struct pkg_message*, local*/->type/**/ = PKG_MESSAGE_REMOVE/**//**/;
			else if (strcasecmp/**/(ucl_object_tostring/**/(elt/*const ucl_object_t*, local*/)/**/, "upgrade"/*char[]*/)/**/ == 0/*int*//*int*/)
				msg/*struct pkg_message*, local*/->type/**/ = PKG_MESSAGE_UPGRADE/**//**/;
			else
				pkg_emit_error/**/("Unknown message type,"
				    " message will always be printed"/*char[]*/)/**/;
		}
		if (msg/*struct pkg_message*, local*/->type/**/ != PKG_MESSAGE_UPGRADE/**//*int*/) {
			LL_APPEND/**/(pkg/*struct pkg*, local*/->message/**/,
				      msg/*struct pkg_message*, local*/)/**/;
			continue;
		}

		elt/*const ucl_object_t*, local*/ = ucl_object_find_key/**/(cur/*const ucl_object_t*, local*/,
									    "minimum_version"/*char[]*/)/**//*const ucl_object_t*, local*/;
		if (elt/*const ucl_object_t*, local*/ != NULL/*void**//*int*/ && ucl_object_type/**/(elt/*const ucl_object_t*, local*/)/**/ == UCL_STRING/**//*int*//*int*/) {
			msg/*struct pkg_message*, local*/->minimum_version/**/ = strdup/**/(ucl_object_tostring/**/(elt/*const ucl_object_t*, local*/)/**/)/**//**/;
			if (msg/*struct pkg_message*, local*/->minimum_version/**/ == NULL/*void**//*int*/) {
				pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
				return (EPKG_FATAL/**/)/**/;
			}
		}

		elt/*const ucl_object_t*, local*/ = ucl_object_find_key/**/(cur/*const ucl_object_t*, local*/,
									    "maximum_version"/*char[]*/)/**//*const ucl_object_t*, local*/;
		if (elt/*const ucl_object_t*, local*/ != NULL/*void**//*int*/ && ucl_object_type/**/(elt/*const ucl_object_t*, local*/)/**/ == UCL_STRING/**//*int*//*int*/) {
			msg/*struct pkg_message*, local*/->maximum_version/**/ = strdup/**/(ucl_object_tostring/**/(elt/*const ucl_object_t*, local*/)/**/)/**//**/;
			if (msg/*struct pkg_message*, local*/->maximum_version/**/ == NULL/*void**//*int*/) {
				pkg_emit_errno/**/("strdup"/*char[]*/, __func__/**/)/**/;
				return (EPKG_FATAL/**/)/**/;
			}
		}

		LL_APPEND/**/(pkg/*struct pkg*, local*/->message/**/,
			      msg/*struct pkg_message*, local*/)/**/;
	}

	return (EPKG_OK/**/)/**/;
}

int
pkg_message_from_str(struct pkg *pkg, const char *str, size_t len)
{
	struct ucl_parser *parser;
	ucl_object_t *obj;
	int ret = EPKG_FATAL/**/;

	assert/**/(str/*const char*, local*/ != NULL/*void**//*int*/)/**/;

	if (len/*size_t, local*/ == 0/*int*//*int*/) {
		len/*size_t, local*/ = strlen/**/(str/*const char*, local*/)/**//*size_t, local*/;
	}

	parser/*struct ucl_parser*, local*/ = ucl_parser_new/**/(0/*int*/)/**//*struct ucl_parser*, local*/;

	if (ucl_parser_add_chunk/**/(parser/*struct ucl_parser*, local*/, (const unsigned char*)str/*const char*, local*//*const unsigned char**/, len/*size_t, local*/)/**/) {
		obj/*ucl_object_t*, local*/ = ucl_parser_get_object/**/(parser/*struct ucl_parser*, local*/)/**//*ucl_object_t*, local*/;
		ucl_parser_free/**/(parser/*struct ucl_parser*, local*/)/**/;

		ret/*int, local*/ = pkg_message_from_ucl/*int(struct pkg*pkg const ucl_object_t*obj)*/(pkg/*struct pkg*, local*/,
												       obj/*ucl_object_t*, local*/)/*int*//*int, local*/;
		ucl_object_unref/**/(obj/*ucl_object_t*, local*/)/**/;

		return (ret/*int, local*/)/*int, local*/;
	}

	ucl_parser_free/**/ (parser/*struct ucl_parser*, local*/)/**/;

	return (ret/*int, local*/)/*int, local*/;
}

ucl_object_t*
pkg_message_to_ucl(const struct pkg *pkg)
{
	struct pkg_message *msg;
	ucl_object_t *array;
	ucl_object_t *obj;

	array/*ucl_object_t*, local*/ = ucl_object_typed_new/**/(UCL_ARRAY/**/)/**//*ucl_object_t*, local*/;
	LL_FOREACH(pkg/*const struct pkg*, local*/->message/**/,
		   msg/*struct pkg_message*, local*/) {
		obj/*ucl_object_t*, local*/ = ucl_object_typed_new/**/ (UCL_OBJECT/**/)/**//*ucl_object_t*, local*/;

		ucl_object_insert_key/**/(obj/*ucl_object_t*, local*/,
		    ucl_object_fromstring_common/**/(msg/*struct pkg_message*, local*/->str/**/, 0/*int*/,
						     UCL_STRING_RAW/**/|UCL_STRING_TRIM/**//**/)/**/,
		    "message"/*char[]*/, 0/*int*/, false/**/)/**/;

		switch (msg/*struct pkg_message*, local*/->type/**/) {
		case PKG_MESSAGE_ALWAYS/**/:
			break;
		case PKG_MESSAGE_INSTALL/**/:
			ucl_object_insert_key/**/(obj/*ucl_object_t*, local*/,
			    ucl_object_fromstring/**/("install"/*char[]*/)/**/,
			    "type"/*char[]*/, 0/*int*/, false/**/)/**/;
			break;
		case PKG_MESSAGE_UPGRADE/**/:
			ucl_object_insert_key/**/(obj/*ucl_object_t*, local*/,
			    ucl_object_fromstring/**/("upgrade"/*char[]*/)/**/,
			    "type"/*char[]*/, 0/*int*/, false/**/)/**/;
			break;
		case PKG_MESSAGE_REMOVE/**/:
			ucl_object_insert_key/**/(obj/*ucl_object_t*, local*/,
			    ucl_object_fromstring/**/("remove"/*char[]*/)/**/,
			    "type"/*char[]*/, 0/*int*/, false/**/)/**/;
			break;
		}
		if (msg/*struct pkg_message*, local*/->maximum_version/**/) {
			ucl_object_insert_key/**/(obj/*ucl_object_t*, local*/,
			    ucl_object_fromstring/**/(msg/*struct pkg_message*, local*/->maximum_version/**/)/**/,
			    "maximum_version"/*char[]*/, 0/*int*/, false/**/)/**/;
		}
		if (msg/*struct pkg_message*, local*/->minimum_version/**/) {
			ucl_object_insert_key/**/(obj/*ucl_object_t*, local*/,
			    ucl_object_fromstring/**/(msg/*struct pkg_message*, local*/->minimum_version/**/)/**/,
			    "minimum_version"/*char[]*/, 0/*int*/, false/**/)/**/;
		}
		ucl_array_append/**/(array/*ucl_object_t*, local*/, obj/*ucl_object_t*, local*/)/**/;
	}

	return (array/*ucl_object_t*, local*/)/*ucl_object_t*, local*/;
}

char*
pkg_message_to_str(struct pkg *pkg)
{
	ucl_object_t *obj;
	char *ret = NULL/*void**/;

	if (pkg/*struct pkg*, local*/->message/**/ == NULL/*void**//*int*/) {
		return (NULL/*void**/)/*void**/;
	}

	obj/*ucl_object_t*, local*/ = pkg_message_to_ucl/*ucl_object_t*(const struct pkg*pkg)*/(pkg/*struct pkg*, local*/)/*ucl_object_t**//*ucl_object_t*, local*/;
	ret/*char*, local*/ = ucl_object_emit/**/(obj/*ucl_object_t*, local*/, UCL_EMIT_JSON_COMPACT/**/)/**//*char*, local*/;
	ucl_object_unref/**/(obj/*ucl_object_t*, local*/)/**/;

	return (ret/*char*, local*/)/*char*, local*/;
}
-------------- next part --------------
init_defs_builtins: /usr/local/lib/coccinelle/standard.h

PARSING: libpkg/pkg.c
(ONCE) CPP-found ifdef-mid-something
(ONCE) CPP-TYPEDEF: promoting:(2) va_list on line 178
(ONCE) CPP-TYPEDEF: promoting:(5) bool on line 260
(ONCE) CPP-MACRO: found foreach: LL_FOREACH
(ONCE) CPP-TYPEDEF: promoting:(2) pkg_attr on line 462
(ONCE) CPP-TYPEDEF: promoting:(14) type on line 538
(ONCE) CPP-TYPEDEF: promoting:(2) pkg_script on line 905
(ONCE) CPP-TYPEDEF: promoting:(2) pkg_script on line 919
(ONCE) CPP-TYPEDEF: promoting:(2) pkg_script on line 975
(ONCE) CPP-TYPEDEF: promoting:(2) pkg_script on line 1031
(ONCE) CPP-TYPEDEF: promoting:(2) pkg_list on line 1346
passed:restrict 
passed:restrict 
passed:restrict 
passed:restrict 
passed:restrict 
passed:#ifdef F_DUPFD_CLOEXEC 
passed:#else 
passed:if ( ( pkg -> rootfd = dup ( rootfd ) ) == - 1 || fcntl ( pkg -> rootfd , F_SETFD , FD_CLOEXEC ) == - 1 ) { 
passed:#endif 
-----------------------------------------------------------------------
maybe 10 most problematic tokens
-----------------------------------------------------------------------
type: present in 4 parsing errors
example: 
       	assert(cmd != NULL && cmd[0] != '\0');
       
       	if (pkg->scripts[type] == NULL)
       		utstring_new(pkg->scripts[type]);
NULL: present in 3 parsing errors
example: 
       	assert(cmd != NULL && cmd[0] != '\0');
       
       	if (pkg->scripts[type] == NULL)
       		utstring_new(pkg->scripts[type]);
pkg: present in 3 parsing errors
example: 
       	assert(cmd != NULL && cmd[0] != '\0');
       
       	if (pkg->scripts[type] == NULL)
       		utstring_new(pkg->scripts[type]);
assert: present in 2 parsing errors
example: 
       	assert(cmd != NULL && cmd[0] != '\0');
       
       	if (pkg->scripts[type] == NULL)
       		utstring_new(pkg->scripts[type]);
cmd: present in 2 parsing errors
example: 
       	assert(cmd != NULL && cmd[0] != '\0');
       
       	if (pkg->scripts[type] == NULL)
       		utstring_new(pkg->scripts[type]);
data: present in 2 parsing errors
example: 
       	char *filename;
       	char *data;
       	pkg_script type;
       	int ret = EPKG_OK;
pkg_script: present in 2 parsing errors
example: 
       	char *filename;
       	char *data;
       	pkg_script type;
       	int ret = EPKG_OK;
scripts: present in 2 parsing errors
example: 
       	assert(cmd != NULL && cmd[0] != '\0');
       
       	if (pkg->scripts[type] == NULL)
       		utstring_new(pkg->scripts[type]);
filename: present in 1 parsing errors
example: 
       	char *filename;
       	char *data;
       	pkg_script type;
       	int ret = EPKG_OK;
utstring_renew: present in 1 parsing errors
example: 
       
       	assert(pkg != NULL);
       	utstring_renew(pkg->scripts[type]);
       	utstring_printf(pkg->scripts[type], "%s", data);
-----------------------------------------------------------------------
NB total files = 1; perfect = 0; pbs = 1; timeout = 0; =========> 0%
nb good = 1875,  nb passed = 9 =========> 0.43% passed
nb good = 1875,  nb bad = 194 =========> 90.66% good or passed
