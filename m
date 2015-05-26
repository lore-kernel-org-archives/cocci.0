From: zied.habtoul@gmail.com (Zied Habtoul)
Date: Tue, 26 May 2015 19:57:09 +0200
Subject: [Cocci] iteration.cocci
In-Reply-To: <alpine.DEB.2.10.1505261912370.2971@hadrien>
References: <CABBGRWtGqhJG4ZUfquga8SY4ASOcAuQP-Oug-gobhS9LMspx9A@mail.gmail.com>
 <alpine.DEB.2.10.1505261912370.2971@hadrien>
Message-ID: <CABBGRWui_CzjQBsCSrUbsUuYhjqtW1uOJ1MzK-ygG58NojhBNw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

virtual after_start
> @initialize:ocaml@
> @@
> let tbl = Hashtbl.create(100)
> let add_if_not_present from f file =
> try let _ = Hashtbl.find tbl (f,file) in ()
> with Not_found ->
> Hashtbl.add tbl (f,file) file;
> let it = new iteration()


how the f file is created ?
i have a file that contains a list of functions , i want to apply a script
to my code when it  detects a function not present in my file.

2015-05-26 19:17 GMT+02:00 Julia Lawall <julia.lawall@lip6.fr>:

> On Tue, 26 May 2015, Zied Habtoul wrote:
>
> > hello,
> >  Can you tell me please what is the function of this part in the
> > file coccinelle/demos/iteration.cocci
> >
> > virtual after_start
> > @initialize:ocaml@
> > @@
> > let tbl = Hashtbl.create(100)
> > let add_if_not_present from f file =
> > try let _ = Hashtbl.find tbl (f,file) in ()
> > with Not_found ->
> > Hashtbl.add tbl (f,file) file;
> > let it = new iteration() in
>
> Obtain a data structure representing another runthat you would like to do
> on the code base.
>
> > (match file with
> > Some fl -> it#set_files [fl]
> > | None -> ());
>
> Choose the set of files to which the new run should apply.  If nothing is
> specified, then the same set of files a used in the current run is used.
>
> > it#add_virtual_rule After_start;
>
> Consider that the virtual rule after_start is satisfied.  Virtual rules
> are like a big if on your semantic patch.  In the header of a semantic
> patch you can say that it eg depends on after_start or depends on
> !after_start to cause the rule to be applied if and only if someother rule
> has or has not matched.  You can also do this for the names of actual
> rules.  Virtual rules can also be activated on the command line.  So you
> could say spatch --sp-file foo.cocci foo.c -D after_start.
>
> > it#add_virtual_identifier Err_ptr_function f;
>
> This is an identifier typed metavariable that is given a value.  In the
> code it can be referred to as identifier virtual.err_ptr_function.
>
> > it#register()
>
> After setting up all the command line variables for the next iteration,
> this calls puts it in a queue to be executed at some time in the future.
>
> julia
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150526/fbcb993d/attachment.html>
