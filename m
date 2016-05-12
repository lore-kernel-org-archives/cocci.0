From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 12 May 2016 05:35:58 +0200
Subject: [Cocci] remove redundant const qualifiers from function
	arguments
In-Reply-To: <20160511184830.GG3766@xsjsorenbubuntu>
References: <20160511031419.GY3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110738430.5606@hadrien>
 <20160511055515.GA3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110758230.5606@hadrien>
 <20160511060438.GB3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605111148220.5036@hadrien>
 <20160511184830.GG3766@xsjsorenbubuntu>
Message-ID: <66c62c8e-43cd-dbab-7a0a-8d884362a141@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I think I have a test case that is minimal.

How do you think about to try a bit more fine-tuning out for the shown
Coccinelle scripts?

How much will it matter for your change pattern to specify only the
deletion of the qualifier "const" from a data type of a function
parameter while leaving the corresponding metavariable "T" untouched?

@removal@
identifier F, I;
type T;
@@
 F(...,
-  const
   T I,
  ...
 );


By the way: Do you care how often a "const" might appear within a data type?

Regards,
Markus
