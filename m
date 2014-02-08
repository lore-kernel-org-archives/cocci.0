From: christoph@burschka.de (Christoph Burschka)
Date: Sat, 08 Feb 2014 16:34:55 +0100
Subject: [Cocci] -o option fails when all files are skipped
Message-ID: <52F64E9F.1080605@burschka.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

(Posted earlier at https://github.com/coccinelle/coccinelle/issues/16 )

-----
Using the latest source (1.0.0-rc19), I'm trying to run this command:

spatch --no-includes --sp-file repr.cocci in.c -o out.c

This is the output I'm getting:

init_defs_builtins:
/home/christoph/Software/install/share/coccinelle/standard.h
warning: line 9: should self be a metavariable?
warning: line 22: should self be a metavariable?
(ONCE) Expected tokens self PyObject PyString_FromString PyString_FromFormat
Skipping:in.c
Fatal error: exception Failure("-o can not be applied because there are
multiple modified files")
-----

Apparently this is because the only input file is skipped.

I was assuming that spatch would simply copy the unchanged input file in
that case, probably because I misinterpreted the following code block in
main.ml:

    (match outfiles with
    | [infile, Some outfile] when infile =$= x && null xs ->
        Common.command2 ("cp " ^outfile^ " " ^ !output_file)
    | [infile, None] when infile =$= x && null xs ->
        Common.command2 ("cp " ^infile^ " " ^ !output_file)
    | _ ->
        failwith

(Instead, outfiles is an empty list. I guess it filters out the
irrelevant files before reaching this point? Sorry, I've never looked at
this source code before today.)

I'm trying to use this tool: https://fedorahosted.org/2to3c/

It applies a collection of semantic patches to a Python2 C extension to
upgrade it to Python3... but apparently it fails when any of those
patches are irrelevant. Is there a better way to do this?

Best regards,
Christoph

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 246 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140208/d9baa20a/attachment.asc>
