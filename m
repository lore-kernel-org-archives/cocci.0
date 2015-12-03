From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Fri, 4 Dec 2015 00:48:32 +0100
Subject: [Cocci] how to find missing initializer
In-Reply-To: <alpine.DEB.2.10.1512032310280.2777@hadrien>
References: <56603DC3.8040609@hurleysoftware.com> <56608E06.9060003@metafoo.de>
 <alpine.DEB.2.10.1512032310280.2777@hadrien>
Message-ID: <20151203234832.GB20409@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Dec 03, 2015 at 11:12:56PM +0100, Julia Lawall wrote:
> > Usually you'd do something like first find all that have the initializer and
> > then match all that where not matched before using a position metavariable. E.g.
> >
> > @r1@
> > identifier fops;
> > identifier fn;
> > position p;
> > @@
> > struct tty_operations fops at p = {
> >     ...,
> >     .cleanup = fn,
> >     ...
> > };
> 
> You don't need the ...  Coccinelle is very relaxed about matching
> structure initializers.    What you provide should be a subset, in any
> order, of what is present.  The ... would only be needed if you want to
> add a new field initialization, and to force it to the beginning or end
> of the structure.
> 
> Luis, why did you use a regular expression for cleanup?

You're right no need:

virtual context                                                                 
                                                                                
@ is_tty @                                                                      
identifier fops;                                                                
@@                                                                              
struct tty_operations fops = {                                                  
};                                                                              
                                                                                
@ tty_has_cleanup depends on is_tty @                                           
identifier is_tty.fops;                                                         
identifier fn;                                                                  
@@                                                                              
struct tty_operations fops = {                                                  
        .cleanup = fn,                                                          
};                                                                              
                                                                                
@ depends on is_tty && !tty_has_cleanup && context @                            
identifier is_tty.fops;                                                         
@@                                                                              
* struct tty_operations fops = {                                                
};
