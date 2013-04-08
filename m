From: mstefani@redhat.com (Michael Stefaniuc)
Date: Mon, 08 Apr 2013 10:57:21 +0200
Subject: [Cocci] parameter list to expression list?
In-Reply-To: <alpine.DEB.2.02.1303271828220.1904@hadrien>
References: <515076A4.1030701@redhat.com>
 <alpine.DEB.2.02.1303252225550.2046@localhost6.localdomain6>
 <5150D63B.9000806@redhat.com> <alpine.DEB.2.02.1303271828220.1904@hadrien>
Message-ID: <51628671.3040508@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Julia,

On 03/27/2013 06:31 PM, Julia Lawall wrote:
> Could you try the attached patch?  The line numbers are almost certain not
> to work out, but maybe it will be able to figure out what to do.
sorry for the late reply. The patch works like a charm.

Thanks!
bye
	michael

> 
> The idea is to do the following:
> 
> @r@
> parameter list P;
> expression list E;
> @@
> 
> main(P at E) {
> + foo(E);
>   return 0;
> }
> 
> julia
> 
