select category_id,title from magefan_blog_category;
select * from magefan_blog_post_category;
select * from magefan_blog_post;

select * from
magefan_blog_category cat
inner join magefan_blog_post_category post_cat on cat.category_id=post_cat.category_id
inner join magefan_blog_post post on post_cat.post_id=post.post_id;

select category_id,title from magefan_blog_category;

select post_id,title,identifier,content_heading,content,creation_time,update_time,publish_time,is_active from magefan_blog_post;

select post.post_id,post.title,post.identifier,post.content_heading,post.creation_time,post.update_time,post.publish_time,post.is_active,
(select category_id from  magefan_blog_post_category post_cat where post_cat.post_id=post.post_id limit 1) as category_id
from magefan_blog_post post;


-- WORKING QUERY
-- INSERT INTO wp_posts (post_date_gmt,post_date,post_content,post_title,post_name,post_modified,post_modified_gmt,comment_count)
-- SELECT POST.creation_time,POST.creation_time,POST.content,POST.title,POST.identifier,POST.update_time,POST.update_time,(select category_id from  magefan_blog_post_category post_cat where post_cat.post_id=POST.post_id limit 1) as category_id FROM magefan_blog_post POST

-- working query for post and category relation
insert into  wp_term_relationships(object_id, term_taxonomy_id,term_order)
select id,term_id,0 from wp_posts post inner join wp_terms term on post.comment_count=term_group where post.comment_count!=0;


SELECT post_content FROM `wp_posts` where post_content like '%www.kttape.com/pub/media/wysiwyg/blog%'


SELECT REPLACE(post_content,'www.kttape.com/pub/media/wysiwyg/blog','ba8c11ad2a.nxcli.net/sites/kttape/w/wordpress/wp-content/uploads/') FROM `wp_posts` where post_content like '%www.kttape.com/pub/media/wysiwyg/blog%'

update wp_posts set post_content=REPLACE(post_content,'www.kttape.com/pub/media/wysiwyg/blog','ba8c11ad2a.nxcli.net/sites/kttape/w/wordpress/wp-content/uploads/')
where id=2507

update wp_posts set post_content=REPLACE(post_content,'www.kttape.com/pub/media/wysiwyg/blog','ba8c11ad2a.nxcli.net/sites/kttape/w/wordpress/wp-content/uploads/')
where id=4102




select * from magefan_blog_category_store;
select * from magefan_blog_post_store;



select * from magefan_blog_comment;
select * from magefan_blog_post_relatedpost;
select * from magefan_blog_post_relatedproduct;

select * from magefan_blog_post_tag;
select * from magefan_blog_tag;

