From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Jun 2013 20:53:19 +0200 (CEST)
Subject: [Cocci] Removing pointer declaration
In-Reply-To: <20130608172853.GA2997@katana>
References: <20130608172853.GA2997@katana>
Message-ID: <alpine.DEB.2.02.1306082052560.1968@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 8 Jun 2013, Wolfram Sang wrote:

> Hi,
> 
> This spatch:
> 
> @@
> int *p;

This should be "identifier p".

julia

> @@
> 
> -	int *p;
> 
> with this code:
> 
> 
> int main()
> {
> 	int *a;
> 
> 	return 0;
> }
> 
> results in:
> 
> Fatal error: exception Failure("minus: parse error: 
>  = File "test.cocci", line 5, column 7,  charpos = 22
>     around = 'p', whole content = -	int *p;
> ")
> 
> using:
> 
> spatch version 1.0.0-rc15 with Python support and with PCRE support
> (although dpkg says it is rc16)
> 
> Am I doing something wrong?
> 
> Thanks,
> 
>    Wolfram
> 
