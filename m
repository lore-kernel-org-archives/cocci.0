From: guenter@roeck-us.net (Guenter Roeck)
Date: Sat, 14 Jan 2017 03:42:46 -0800
Subject: [Cocci] Coccinelle problems
In-Reply-To: <alpine.DEB.2.20.1701131600300.2041@hadrien>
References: <d03925e4-f9a0-533c-02b3-b12d3f8236de@roeck-us.net>
 <alpine.DEB.2.20.1701131521480.2041@hadrien>
 <7874d064-1889-3301-d4f0-18c37e37234b@roeck-us.net>
 <alpine.DEB.2.20.1701131600300.2041@hadrien>
Message-ID: <0401d8b1-f571-a668-04b3-ef3a74094461@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 01/13/2017 07:01 AM, Julia Lawall wrote:
>> @m1 exists@
>> identifier initfn;
>> identifier pdev;
>> type ptype.T;
>> position p;
>> @@
>>
>> initfn at p(T *pdev, ...) {
>>    ...
>>    &pdev->dev
>>    ... when any
>>    &pdev->dev
>>    ... when any
>> }
> This is twice in a single execution path.  Twice anywhere could be done as
> follows:
>
> @@
> position p;
> @@
>
> initfn at p(T *pdev, ...) {
>    <...
>    &pdev at p->dev
>    ...>
> }
>
> Then just inherit p into a python rule and find the number of elements in
> the array.
>
Yes, of course you are right. That finds another 10+ files to transform
in drivers/input alone.

Thanks again!

Guenter
