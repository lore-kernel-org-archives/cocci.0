From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Aug 2017 22:14:35 +0200 (CEST)
Subject: [Cocci] Reading multiple input files
In-Reply-To: <92854f94-595d-180f-5288-c18017c4cc01@embeddedor.com>
References: <92854f94-595d-180f-5288-c18017c4cc01@embeddedor.com>
Message-ID: <alpine.DEB.2.20.1708162211390.3683@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 Aug 2017, Gustavo A. R. Silva wrote:

> Hello everybody,
>
> Is there any way to make a cocci script read from a list of files and run on
> each of them?
>
> The scenario is as follows: I have a list of files that I know may contain
> either actual bugs or false positives. I want to run cocci scripts on each of
> them and I wonder if I can do this using Coccinelle only.
>
> Maybe giving the cocci script a file containing the list as input and, then
> reading the list with a python script from inside the cocci script?
>
> Is this possible?

Yes.  Extracted from the latex documentation:

\rare{-{}-file-groups}{Specify a file that contains the list of files to
  process.  Files should be listed one per line.  Blank lines should be
  used to separate the files into \textit{groups}.  All files within a
  single group will be treated at once.  This is useful, for example, if
  one wants to process a complete driver, that consists of more than one
  file, and it is necessary to consider the interaction between code
  fragments that are present in the different files.  Single-line comments
  beginning with \texttt{//} can be used freely and are ignored.}

In your case, just make a file with a line for each file you are
interested in and separate each of these lines with a blank line.

julia
