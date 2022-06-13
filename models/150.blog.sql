DO
$$
    BEGIN
        CREATE TYPE blog.STATUS AS ENUM ('draft', 'published', 'deleted');
    EXCEPTION
        WHEN duplicate_object THEN NULL;
    END
$$;

CREATE TABLE IF NOT EXISTS blog.post
(
    id         BIGSERIAL PRIMARY KEY,
    title      VARCHAR(255) NOT NULL UNIQUE,
    slug       VARCHAR(200) NOT NULL UNIQUE,
    summary    TEXT,
    published  timestamp,
    created_at timestamp    NOT NULL,
    created_by BIGINT       NOT NULL,
    updated_at timestamp,
    updated_by BIGINT,
    status     blog.STATUS  NOT NULL DEFAULT 'draft',
    content    TEXT         NOT NULL,
    parent_id  BIGINT       NULL,
    meta       JSON         NULL, -- meta data about the post.

    CONSTRAINT fk_blog_author FOREIGN KEY (created_by) REFERENCES users."user" (actorid) ON DELETE NO ACTION,
    CONSTRAINT fk_blog_updater FOREIGN KEY (updated_by) REFERENCES users."user" (actorid) ON DELETE NO ACTION,
    CONSTRAINT fk_blog_parent FOREIGN KEY (parent_id) REFERENCES blog."post" (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS blog.post_comment
(
    id         BIGSERIAL PRIMARY KEY,
    post_id    BIGINT      NOT NULL,
    parent_id  BIGINT      NULL,
    content    TEXT        NOT NULL,
    status     blog.STATUS NOT NULL DEFAULT 'published',

    created_at timestamp   NOT NULL,
    created_by BIGINT      NOT NULL,
    updated_at timestamp,
    updated_by BIGINT,

    CONSTRAINT fk_blog_comment_parent FOREIGN KEY (parent_id) REFERENCES blog.post_comment (id) ON DELETE CASCADE,
    CONSTRAINT fk_blog_post_id FOREIGN KEY (post_id) REFERENCES blog.post (id) ON DELETE CASCADE,
    CONSTRAINT fk_blog_post_comment_author FOREIGN KEY (created_by) REFERENCES users."user" (actorid),
    CONSTRAINT fk_blog_post_comment_updater FOREIGN KEY (updated_by) REFERENCES users."user" (actorid)
);

CREATE TABLE IF NOT EXISTS blog.tags
(
    name        VARCHAR(30) PRIMARY KEY,
    description TEXT,
    created_at  timestamp NOT NULL,
    created_by  BIGINT    NOT NULL
);

CREATE TABLE IF NOT EXISTS blog.post_tags
(
    id         BIGSERIAL PRIMARY KEY,
    post_id    BIGINT      NOT NULL,
    tag        VARCHAR(30) NOT NULL,
    created_at timestamp   NOT NULL,
    created_by BIGINT      NOT NULL
);