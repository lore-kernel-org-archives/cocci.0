From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Wed, 11 Jan 2017 10:53:53 +0530
Subject: [Cocci] [RFC] coccicheck: add a test for repeat memory fetches
In-Reply-To: <CAGXu5jJ55j1r3H2NP8P4Tv4kqu+DZbj+Q6eor6mUcX8eRj4NTQ@mail.gmail.com>
References: <20170109231323.GA89642@beast>
 <alpine.DEB.2.20.1701101927070.1981@hadrien>
 <CAGXu5j+Nk9r7K=FJe4v5b8mX_Fn411JMGks2sueyOFS2aTo1Ow@mail.gmail.com>
 <alpine.DEB.2.20.1701102028300.1981@hadrien>
 <CAGXu5jLT8w6bK8SC4=Wne1BtfPsALiBSeyr6OK_jsCfaiJ+KRg@mail.gmail.com>
 <alpine.DEB.2.20.1701102207590.1981@hadrien>
 <CAGXu5jJ55j1r3H2NP8P4Tv4kqu+DZbj+Q6eor6mUcX8eRj4NTQ@mail.gmail.com>
Message-ID: <0ee2451b-79d1-7bc3-208e-d089002a5b76@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wednesday 11 January 2017 05:34 AM, Kees Cook wrote:
> On Tue, Jan 10, 2017 at 1:14 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> OK, I have the impression that what you are looking for is the following,
>> that currently does not seem to work well. Still maybe it gives an idea.
>>
>> The basic pattern is the following sequence:
>>
>> 1. copy_from_user
>> 2. test on a field of the copied value
>> 3. another copy_from_user
>> 4. a use of the same field as tested in step 2 from the structure obtained
>> by the second copy_from_user or a function call with the structure as an
>> argument
>
> This looks pretty good!
>
>> In the case where the second copy_from_user stores the result in a
>> pointer, then a return with no reference of the tested field is also a
>> concern, unless, the pointer was already kfreed.
>
> I think sequence "2" above missing just looking at a direct value,
> like if instead of a field it was a u32. Also, should binop include
> "=="?
>
> And we need to add back in get_user() too... hmmm

May be having a separate script for get_user would be a good idea. 
get_user needs few more tests than copy_from_user. Also, for the both 
cases we can later add multi-function handling rules. And for the 
get_user, may be combinational usage rule as well.

> -Kees
>
