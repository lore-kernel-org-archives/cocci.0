From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 18 Oct 2016 22:42:21 +0200 (CEST)
Subject: [Cocci] Regression in Python Support
In-Reply-To: <e44a320e-ac7a-1111-1502-c1a91d1750ca@redhat.com>
References: <57FCD273.9070607@redhat.com> <ow4d1ixwqay.fsf@inria.fr>
 <e44a320e-ac7a-1111-1502-c1a91d1750ca@redhat.com>
Message-ID: <alpine.DEB.2.20.1610182242030.2247@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 18 Oct 2016, Michael Stefaniuc wrote:

> Thanks Thierry!
>
> On 10/18/2016 06:54 PM, Thierry Martinez wrote:
> > This should now be fixed in trunk. Thank you for the report.
> >
> > The support of --with-python had been dropped since the Python version
> > was determined during run-time since 1.0.5 (even if it had not been
> > properly documented, sorry for that). The option --with-python is now
> > restored in trunk to specify the name of the default Python
> > interpreter. The interpreter can also be changed by passing the option
> > --python in the command line of spatch.
> >
> > Note that it is still possible that Fedora 23 and 24 are shipped with
> > Python versions that have not been tested yet. If such a similar error
> > is still raised with trunk, would you give me the output of
> > "python3 --version"?
> Coccinelle works now again with python3 on both F23 and F24.

Great :)  Thanks for checking on it.

julia
