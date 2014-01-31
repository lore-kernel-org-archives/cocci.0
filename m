From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 31 Jan 2014 08:01:52 +0100 (CET)
Subject: [Cocci] Need help in patching
In-Reply-To: <CACxTi0bZmwJfHgYuA5PUUGViVkAUAdyeZSDHbwBSoQDQu2=NUQ@mail.gmail.com>
References: <CACxTi0bZmwJfHgYuA5PUUGViVkAUAdyeZSDHbwBSoQDQu2=NUQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1401310757500.2836@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 31 Jan 2014, Utsav Patel wrote:

> Hi, I have just started to use Coccinelle for my final year BTech project
> and I have a question,The code i want to patch depends upon some conditions.
> e.g. replace any array[SIZE] having size > 100 with an
> array[original_size/2]. See, I don't want to replace ALL array[size], but
> only when size>100. So, how do i compare a constant from an expression (here
> in example SIZE) to a value (here in example - 100 ) and perform patching
> depending on that condition only?
> I guess I can get all array and their SIZE in python script and compare
> them,

Yes, you would want to do that.

> but then i don't know how to filter the selected arrays[] and send it
> to another rule to perform patching. Please suggest how can I proceed.

If you find you don't like some information in some python code, you can 
say cocci.include_match(False).  That will drop the information you tested 
as well as the complete matching of metavariables that was created at the 
same time.  Then you can make another matching rule for the same thing 
that inherits the metavariables that you bound in the first rule.  You may 
want to add some position variables to be able to rematch exactly the same 
place, if you don't want to duplicate the entire pattern.  In your second 
matching rule you can do the transformation.

There is an example in the demos directory of the Coccinelle source tree 
(http://www.coccinelle.fr).  The name of the example is first.cocci.

julia
