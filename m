From: Nikolaus@rath.org (Nikolaus Rath)
Date: Wed, 05 Oct 2016 09:09:22 -0700
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <alpine.DEB.2.10.1610050744460.3061@hadrien> (Julia Lawall's
 message of "Wed, 5 Oct 2016 07:45:27 +0200 (CEST)")
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
Message-ID: <87shsa7p71.fsf@thinkpad.rath.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Oct 05 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Tue, 4 Oct 2016, Nikolaus Rath wrote:
>
>> Hello,
>>
>> In a set of C files, I would like to replace each instance of one type
>> (struct fasel_foo) with another type (struct fasel_bar). For instance,
>>
>> char* fasel_foo_print(struct fasel_foo *ptr) {
>>     // ...
>>    return "this struct fasel_foo string should not change";
>> }
>>
>> should become
>>
>> char* fasel_foo_print(struct fasel_bar *ptr) {
>>     // ...
>>    return "this struct fasel_foo string should not change";
>> }
>>
>>
>> Based on the LWN articles that I've read, this seems like the perfect
>> use-case for coccinelle. However, somehow I'm struggling to write a
>> patch for this. All the documentation that I could get my hands on seems
>> to describe more abstract changes that require the use of variables -
>> but as far as I can tell, I need something much simpler:
>>
>> @@
>> "struct fasel_foo must be a type name!"
>> @@
>> - struct fasel_foo
>> + struct fasel_bar
>>
>>
>> ...if only I knew what to put between the @@.
>
> Put nothing :)  From the word struct it should figure out that it is
> working on a type.

Oh, great! Thanks!


This solves my problem, but it makes me wonder how this generalizes to
other problems. For example, 

1. What would I need to do if I don't want to replace a struct but
   something typedef'd? (my_type *ptr --> new_type *ptr).

2. ..and how would I go about if instead of the type, I want to replace
   a variable name? (my_type *ptr --> my_type *pointer).


Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             ?Time flies like an arrow, fruit flies like a Banana.?
