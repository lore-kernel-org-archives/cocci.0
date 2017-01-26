From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jan 2017 16:19:45 +0100 (CET)
Subject: [Cocci] Help with include coccinelle & include paths?
In-Reply-To: <BBB6D7E1-F6F1-4FE4-80D6-8BD4C6F36026@linaro.org>
References: <BBB6D7E1-F6F1-4FE4-80D6-8BD4C6F36026@linaro.org>
Message-ID: <alpine.DEB.2.20.1701261613120.3109@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jan 2017, Kumar Gala wrote:

> Hi,
>
> I?m looking at using coccinelle with the Zephyr project:
>
> https://www.zephyrproject.org/
> https://gerrit.zephyrproject.org/r/gitweb?p=zephyr.git;a=summary
>
> We utilize Kconfig & Kbuild from linux kernel.  However, I?m trying to figure out how to deal with our includes.  I?ve played around with the various options to spatch, but either get a StackOverflow --recursive-includes or not getting all cases figured out since typedef & #defines aren?t getting parsed fully.
>
> Wondering what are best practices or things to try here.  I?m also not clear on what the messages one gets when enable some of the debug options like --verbose-parsing --type-error-msg.

If you just want the includes for parsing and type inference, but not for
transformation, it may help to use --include-headers-for-types.  I'm a bit
surprised about the stack overflow, though.  Maybe there is just some
header file that is badly structured in some way.

Includes won't help you much with #defines.  Coccinelle doesn't normally
take them into account even when the definition is available.  If there
are some non-Linux like macros in your code that reak parsing, you will
need to update standard.h.  What you can do is run:

spatch --parse-c mysoftware

and then it will parse all the files in mysoftware and make a list of the
tokens that most commonly cause errors.  It is usully sufficient to add a
few definitions to standard.h to resolve most of the problems.

Coccinelle parses one top-evel unit (function etc) at a time.  When you
use --verbose-parsing, it will print out the units that have parsing
problems.  It puts BAD on the line with the error, and bad on the lines
that are skipped due to the error.  When there are errors, Coccinelle does
try up to 4 times to parse the code, with each time being a bit more
relaxed.  So something can fail and then ultimately succeed.

I'll run parse-c on the above git link and see if any major issues emerge.

julia
