From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 12 May 2016 09:06:45 +0200 (CEST)
Subject: [Cocci] remove redundant const qualifiers from function
 arguments
In-Reply-To: <20160512055423.GH3766@xsjsorenbubuntu>
References: <20160511031419.GY3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110738430.5606@hadrien>
 <20160511055515.GA3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110758230.5606@hadrien>
 <20160511060438.GB3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605111148220.5036@hadrien>
 <20160511184830.GG3766@xsjsorenbubuntu>
 <66c62c8e-43cd-dbab-7a0a-8d884362a141@users.sourceforge.net>
 <20160512055423.GH3766@xsjsorenbubuntu>
Message-ID: <alpine.DEB.2.10.1605120905380.3316@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > @removal@
> > identifier F, I;
> > type T;
> > @@
> >  F(...,
> > -  const
> >    T I,
> >   ...
> >  );

Oops, now I see why this doesn't parse.  When you make a rule for a
prototype, you need to specify the return type (which could be just T1).
Otherwise, the parser can't tell the difference between this and a
function call.

julia
