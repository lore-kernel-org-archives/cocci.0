From: guenter@roeck-us.net (Guenter Roeck)
Date: Fri, 13 Jan 2017 06:58:19 -0800
Subject: [Cocci] Coccinelle problems
In-Reply-To: <alpine.DEB.2.20.1701131521480.2041@hadrien>
References: <d03925e4-f9a0-533c-02b3-b12d3f8236de@roeck-us.net>
 <alpine.DEB.2.20.1701131521480.2041@hadrien>
Message-ID: <7874d064-1889-3301-d4f0-18c37e37234b@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 01/13/2017 06:24 AM, Julia Lawall wrote:
> Attached is a new version of pdev-simple.cocci.  The rule m1 checks for
> the existence of a &pdev->dev and the rule m2 checks whether there already
> exists a device declaration.  If the first is satisfied and the second is
> not, then the transformation is made using <... ...> rather than <+...
> ...+> which is often nore expensive.
>
> julia

Hi Julia,

as always, you are amazing! Both fixes work like a champ.

I was even able to get "&pdev->dev referenced at least twice" to work with

@m1 exists@
identifier initfn;
identifier pdev;
type ptype.T;
position p;
@@

initfn at p(T *pdev, ...) {
   ...
   &pdev->dev
   ... when any
   &pdev->dev
   ... when any
}


Many thanks!

Guenter
