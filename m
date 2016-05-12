From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 12 May 2016 08:20:59 +0200
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
Message-ID: <fa7b3d89-de71-41a5-11e0-a9522719838a@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I guess that is a valid optimization. But does this go through the
> parsing step? And even if, why doesn't mine?

Would you like to try the following SmPL approach once more?

@prototype_adjustment@
identifier F, I;
type R, T;
@@
 R F(...,
-    const
     T I,
     ...
    );

Regards,
Markus
