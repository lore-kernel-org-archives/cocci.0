From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 9 Feb 2014 07:31:05 +0100 (CET)
Subject: [Cocci] -o option fails when all files are skipped
In-Reply-To: <52F6A70C.4060108@burschka.de>
References: <52F64E9F.1080605@burschka.de>
 <alpine.DEB.2.02.1402081828450.2017@localhost6.localdomain6>
 <52F6A70C.4060108@burschka.de>
Message-ID: <alpine.DEB.2.02.1402090730460.2142@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 8 Feb 2014, Christoph Burschka wrote:

> On 02/08/2014 06:30 PM, Julia Lawall wrote:
> > On Sat, 8 Feb 2014, Christoph Burschka wrote:
> > 
> >> (Posted earlier at https://github.com/coccinelle/coccinelle/issues/16 )
> >>
> >> -----
> >> Using the latest source (1.0.0-rc19), I'm trying to run this command:
> >>
> >> spatch --no-includes --sp-file repr.cocci in.c -o out.c
> >>
> >> This is the output I'm getting:
> >>
> >> init_defs_builtins:
> >> /home/christoph/Software/install/share/coccinelle/standard.h
> >> warning: line 9: should self be a metavariable?
> >> warning: line 22: should self be a metavariable?
> >> (ONCE) Expected tokens self PyObject PyString_FromString PyString_FromFormat
> >> Skipping:in.c
> >> Fatal error: exception Failure("-o can not be applied because there are
> >> multiple modified files")
> >> -----
> >>
> >> Apparently this is because the only input file is skipped.
> >>
> >> I was assuming that spatch would simply copy the unchanged input file in
> >> that case, probably because I misinterpreted the following code block in
> >> main.ml:
> >>
> >>     (match outfiles with
> >>     | [infile, Some outfile] when infile =$= x && null xs ->
> >>         Common.command2 ("cp " ^outfile^ " " ^ !output_file)
> >>     | [infile, None] when infile =$= x && null xs ->
> >>         Common.command2 ("cp " ^infile^ " " ^ !output_file)
> >>     | _ ->
> >>         failwith
> >>
> >> (Instead, outfiles is an empty list. I guess it filters out the
> >> irrelevant files before reaching this point? Sorry, I've never looked at
> >> this source code before today.)
> >>
> >> I'm trying to use this tool: https://fedorahosted.org/2to3c/
> >>
> >> It applies a collection of semantic patches to a Python2 C extension to
> >> upgrade it to Python3... but apparently it fails when any of those
> >> patches are irrelevant. Is there a better way to do this?
> > 
> > Personally, I never use -o.  Normally, Coccinelle prints a patch to the 
> > standard output, and then you can apply the patch to your code.
> > 
> > I can make -o simply copy the file when there is nothing to do, if that is 
> > the desired behavior.
> > 
> > julia
> > 
> 
> Well, it's probably best if I do it differently.
> 
> The project I forked was originally trying to wrap spatch in a string
> function, so it read the source file, wrote it into a temporary file,
> then ran spatch on it with -o, then read the output file, *then*
> generated a diff against the input file... that seems needlessly
> complicated.
> Instead, I've changed it to just run spatch and print the diff output
> that it generates directly.

That seems better :)

julia
