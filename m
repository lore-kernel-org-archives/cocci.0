From: thomas.adam22@gmail.com (Thomas Adam)
Date: Fri, 16 Dec 2016 17:08:15 +0000
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <alpine.DEB.2.10.1612161549220.6500@hadrien>
References: <20161216113410.4vauxw4u2f364l7v@fbsd-laptop>
 <alpine.DEB.2.10.1612161242300.3566@hadrien>
 <20161216131350.5xc6awlrv2yu5xso@fbsd-laptop>
 <alpine.DEB.2.10.1612161453460.6500@hadrien>
 <20161216141242.3tisfzykz5zxcdtu@fbsd-laptop>
 <alpine.DEB.2.10.1612161531110.6500@hadrien>
 <20161216144645.h3tl5m3f5333zif2@fbsd-laptop>
 <alpine.DEB.2.10.1612161549220.6500@hadrien>
Message-ID: <20161216170814.netw7heh2bdyvmm5@fbsd-laptop>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Dec 16, 2016 at 03:56:04PM +0100, Julia Lawall wrote:
> Again, could you end me a .c file that actually does not work?  I
> think that if you run spatch on the pkg.c file that you sent it wlll work.
> At least it seems to work for me.

Interesting.  The .c file example I sent you was just that -- completely cut
down to just pkg_adddep() which does not work for me with the rules I
outlined.

At this point, I'm wondering if I am doing something really dumb here.

> Probbly something about the previous code is causing problems for
> pkg_adddep not to be parsed.  But it would help a lot of have a very small
> example that shows the problem.  You can just binary search - remove some
> stuff and then run spatch --type-c, and then add or remove code
> accordingly to get a small example.  For example, if you remove all the
> code before pkg_adddep and then pkg_adddep parses, then the problem is
> actually related to something coming before.

So I did this, and no matter what I do this file just isn't being parsed at
all.  The smallest test-case is what I've already sent through, but that
implies there's something else going on.

I've got some bad/BAD lines you might want to look at.  But at this point, the
problem is something with the environment.

Thanks again, Julia.

Thomas
-------------- next part --------------
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: libpkg/pkg.c
ERROR-RECOV: found sync '}' at line 914
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 914
parse error 
 = File "libpkg/pkg.c", line 910, column 29,  charpos = 21210
    around = 'type', whole content = 	utstring_renew(pkg->scripts[type]);
badcount: 11
bad: }
bad: 
bad: int
bad: pkg_addscript(struct pkg *pkg, const char *data, pkg_script type)
bad: {
bad: 
bad: 	assert(pkg != NULL);
BAD:!!!!! 	utstring_renew(pkg->scripts[type]);
bad: 	utstring_printf(pkg->scripts[type], "%s", data);
bad: 
bad: 	return (EPKG_OK);
bad: }
ERROR-RECOV: found sync '}' at line 969
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 969
semantic error two or more data types: t Tag9 ((["pkg_script"; ((("pkg_script", 21379, 920, 1, "libpkg/pkg.c")), (0), ((0, 0, 0, 0)), 0, (3))]), 0) ii 0
typeD Tag9 ((["type"; ((("type", 21390, 920, 12, "libpkg/pkg.c")), (0), ((0, 0, 0, 0)), 0, (3))]), 0) ii2 0

 =File "libpkg/pkg.c", line 920, column 16,  charpos = 21394
    around = ';', whole content = 	pkg_script type;
badcount: 55
bad: }
bad: 
bad: int
bad: pkg_addscript_fileat(int fd, struct pkg *pkg, const char *filename)
bad: {
bad: 	char *data;
BAD:!!!!! 	pkg_script type;
bad: 	int ret = EPKG_OK;
bad: 	off_t sz = 0;
bad: 
bad: 	assert(pkg != NULL);
bad: 	assert(filename != NULL);
bad: 
bad: 	pkg_debug(1, "Adding script from: '%s'", filename);
bad: 
bad: 	if ((ret = file_to_bufferat(fd, filename, &data, &sz)) != EPKG_OK)
bad: 		return (ret);
bad: 
bad: 	if (strcmp(filename, "pkg-pre-install") == 0 ||
bad: 			strcmp(filename, "+PRE_INSTALL") == 0) {
bad: 		type = PKG_SCRIPT_PRE_INSTALL;
bad: 	} else if (strcmp(filename, "pkg-post-install") == 0 ||
bad: 			strcmp(filename, "+POST_INSTALL") == 0) {
bad: 		type = PKG_SCRIPT_POST_INSTALL;
bad: 	} else if (strcmp(filename, "pkg-install") == 0 ||
bad: 			strcmp(filename, "+INSTALL") == 0) {
bad: 		type = PKG_SCRIPT_INSTALL;
bad: 	} else if (strcmp(filename, "pkg-pre-deinstall") == 0 ||
bad: 			strcmp(filename, "+PRE_DEINSTALL") == 0) {
bad: 		type = PKG_SCRIPT_PRE_DEINSTALL;
bad: 	} else if (strcmp(filename, "pkg-post-deinstall") == 0 ||
bad: 			strcmp(filename, "+POST_DEINSTALL") == 0) {
bad: 		type = PKG_SCRIPT_POST_DEINSTALL;
bad: 	} else if (strcmp(filename, "pkg-deinstall") == 0 ||
bad: 			strcmp(filename, "+DEINSTALL") == 0) {
bad: 		type = PKG_SCRIPT_DEINSTALL;
bad: 	} else if (strcmp(filename, "pkg-pre-upgrade") == 0 ||
bad: 			strcmp(filename, "+PRE_UPGRADE") == 0) {
bad: 		type = PKG_SCRIPT_PRE_UPGRADE;
bad: 	} else if (strcmp(filename, "pkg-post-upgrade") == 0 ||
bad: 			strcmp(filename, "+POST_UPGRADE") == 0) {
bad: 		type = PKG_SCRIPT_POST_UPGRADE;
bad: 	} else if (strcmp(filename, "pkg-upgrade") == 0 ||
bad: 			strcmp(filename, "+UPGRADE") == 0) {
bad: 		type = PKG_SCRIPT_UPGRADE;
bad: 	} else {
bad: 		pkg_emit_error("unknown script '%s'", filename);
bad: 		ret = EPKG_FATAL;
bad: 		goto cleanup;
bad: 	}
bad: 
bad: 	ret = pkg_addscript(pkg, data, type);
bad: cleanup:
bad: 	free(data);
bad: 	return (ret);
bad: }
ERROR-RECOV: found sync '}' at line 1029
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 1029
semantic error two or more data types: t Tag9 ((["pkg_script"; ((("pkg_script", 23073, 976, 1, "libpkg/pkg.c")), (0), ((0, 0, 0, 0)), 0, (3))]), 0) ii 0
typeD Tag9 ((["type"; ((("type", 23084, 976, 12, "libpkg/pkg.c")), (0), ((0, 0, 0, 0)), 0, (3))]), 0) ii2 0

 =File "libpkg/pkg.c", line 976, column 16,  charpos = 23088
    around = ';', whole content = 	pkg_script type;
badcount: 60
bad: }
bad: 
bad: int
bad: pkg_addscript_file(struct pkg *pkg, const char *path)
bad: {
bad: 	char *filename;
bad: 	char *data;
BAD:!!!!! 	pkg_script type;
bad: 	int ret = EPKG_OK;
bad: 	off_t sz = 0;
bad: 
bad: 	assert(pkg != NULL);
bad: 	assert(path != NULL);
bad: 
bad: 	pkg_debug(1, "Adding script from: '%s'", path);
bad: 
bad: 	if ((ret = file_to_buffer(path, &data, &sz)) != EPKG_OK)
bad: 		return (ret);
bad: 
bad: 	filename = strrchr(path, '/');
bad: 	filename[0] = '\0';
bad: 	filename++;
bad: 
bad: 	if (strcmp(filename, "pkg-pre-install") == 0 ||
bad: 			strcmp(filename, "+PRE_INSTALL") == 0) {
bad: 		type = PKG_SCRIPT_PRE_INSTALL;
bad: 	} else if (strcmp(filename, "pkg-post-install") == 0 ||
bad: 			strcmp(filename, "+POST_INSTALL") == 0) {
bad: 		type = PKG_SCRIPT_POST_INSTALL;
bad: 	} else if (strcmp(filename, "pkg-install") == 0 ||
bad: 			strcmp(filename, "+INSTALL") == 0) {
bad: 		type = PKG_SCRIPT_INSTALL;
bad: 	} else if (strcmp(filename, "pkg-pre-deinstall") == 0 ||
bad: 			strcmp(filename, "+PRE_DEINSTALL") == 0) {
bad: 		type = PKG_SCRIPT_PRE_DEINSTALL;
bad: 	} else if (strcmp(filename, "pkg-post-deinstall") == 0 ||
bad: 			strcmp(filename, "+POST_DEINSTALL") == 0) {
bad: 		type = PKG_SCRIPT_POST_DEINSTALL;
bad: 	} else if (strcmp(filename, "pkg-deinstall") == 0 ||
bad: 			strcmp(filename, "+DEINSTALL") == 0) {
bad: 		type = PKG_SCRIPT_DEINSTALL;
bad: 	} else if (strcmp(filename, "pkg-pre-upgrade") == 0 ||
bad: 			strcmp(filename, "+PRE_UPGRADE") == 0) {
bad: 		type = PKG_SCRIPT_PRE_UPGRADE;
bad: 	} else if (strcmp(filename, "pkg-post-upgrade") == 0 ||
bad: 			strcmp(filename, "+POST_UPGRADE") == 0) {
bad: 		type = PKG_SCRIPT_POST_UPGRADE;
bad: 	} else if (strcmp(filename, "pkg-upgrade") == 0 ||
bad: 			strcmp(filename, "+UPGRADE") == 0) {
bad: 		type = PKG_SCRIPT_UPGRADE;
bad: 	} else {
bad: 		pkg_emit_error("unknown script '%s'", filename);
bad: 		ret = EPKG_FATAL;
bad: 		goto cleanup;
bad: 	}
bad: 
bad: 	ret = pkg_addscript(pkg, data, type);
bad: cleanup:
bad: 	free(data);
bad: 	return (ret);
bad: }
ERROR-RECOV: found sync '}' at line 1044
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 1044
parse error 
 = File "libpkg/pkg.c", line 1038, column 18,  charpos = 24881
    around = 'type', whole content = 	if (pkg->scripts[type] == NULL)
badcount: 15
bad: }
bad: 
bad: int
bad: pkg_appendscript(struct pkg *pkg, const char *cmd, pkg_script type)
bad: {
bad: 
bad: 	assert(pkg != NULL);
bad: 	assert(cmd != NULL && cmd[0] != '\0');
bad: 
BAD:!!!!! 	if (pkg->scripts[type] == NULL)
bad: 		utstring_new(pkg->scripts[type]);
bad: 
bad: 	utstring_printf(pkg->scripts[type], "%s", cmd);
bad: 
bad: 	return (EPKG_OK);
bad: }
TYPEDEF CONFLICT:type
transforming some ident into a typedef
Note: processing took    13.2s: libpkg/pkg.c
