From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 11 May 2016 22:54:23 -0700
Subject: [Cocci] remove redundant const qualifiers from function
	arguments
In-Reply-To: <66c62c8e-43cd-dbab-7a0a-8d884362a141@users.sourceforge.net>
References: <20160511031419.GY3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110738430.5606@hadrien>
 <20160511055515.GA3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110758230.5606@hadrien>
 <20160511060438.GB3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605111148220.5036@hadrien>
 <20160511184830.GG3766@xsjsorenbubuntu>
 <66c62c8e-43cd-dbab-7a0a-8d884362a141@users.sourceforge.net>
Message-ID: <20160512055423.GH3766@xsjsorenbubuntu>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Markus,

On Thu, 2016-05-12 at 05:35:58 +0200, SF Markus Elfring wrote:
> > I think I have a test case that is minimal.
> 
> How do you think about to try a bit more fine-tuning out for the shown
> Coccinelle scripts?
>
> How much will it matter for your change pattern to specify only the
> deletion of the qualifier "const" from a data type of a function
> parameter while leaving the corresponding metavariable "T" untouched?

Well, is there anything wrong with my patches? I don't argue that they
could be optimized but as long as there is nothing wrong with them
things should work, shouldn't they?
Does your changed version behave correctly in all cases?

> 
> @removal@
> identifier F, I;
> type T;
> @@
>  F(...,
> -  const
>    T I,
>   ...
>  );

I guess that is a valid optimization. But does this go through the
parsing step? And even if, why doesn't mine?

> By the way: Do you care how often a "const" might appear within a data type?

No, I don't. My goal was to get rid of all const qualifiers that affect
local variables only. E.g.:
 - const int foo => int foo
 - const int *foo => const int *foo (data pointed to shall remain const)
 - const int * const foo => const int *foo

	S?ren
