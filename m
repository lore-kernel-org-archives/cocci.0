From: joel@joelfernandes.org (Joel Fernandes)
Date: Thu, 11 Oct 2018 11:07:53 -0700
Subject: [Cocci] Searching for parameter usages of pte_alloc()
In-Reply-To: <alpine.DEB.2.20.1810111833410.3392@hadrien>
References: <20181010211125.GA128537@joelaf.mtv.corp.google.com>
 <93da55ff-c807-6587-7ef3-3d2af820117d@users.sourceforge.net>
 <20181011154346.GA186033@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.20.1810111746210.3392@hadrien>
 <20181011162840.GA199386@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.20.1810111833410.3392@hadrien>
Message-ID: <20181011180753.GB247511@joelaf.mtv.corp.google.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Oct 11, 2018 at 06:40:22PM +0200, Julia Lawall wrote:
> > Sure, so if I have code like this:
> > #define pte_alloc_one(mm, vmaddr) ((pte_t *) page_table_alloc(mm))
> >
> > I want to have a rule that does:
> > - #define pte_alloc_one(mm, vmaddr) ((pte_t *) page_table_alloc(mm))
> > + #define pte_alloc_one(mm) ((pte_t *) page_table_alloc(mm))
> >
> > So far everything I tried only works for functions so I was wondering how one
> > do this with macros.
> 
> Maybe
> 
> @r@
> position p;
> identifier i,a,b;
> @@
> 
> #define i(a,b)@p <+...b...+>
> 
> @@
> position p != r.p;
> identifier i,a,b;
> expresssion e;
> @@
> 
> - #define i(a,b)@p e
> + #define i(a) e

Sorry, it works now. I had not defined 'position p' in the rule. Please
ignore my noise.
