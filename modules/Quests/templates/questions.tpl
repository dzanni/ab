<div class="quest__list">
    {foreach from=$result item=data}
        <div class="quest__item js_quest_item {if $data.is_news}news_item{/if} {if $data.main}main_item{/if}">
            <div class="quest__item-inner">
                <div class="quest__item-photo">
                    <img class="quest__item-img" src="{$viewer->get_icon_by_user($data.user)}" alt="{$data.family_name} {$data.name}">
                </div>
                <div class="quest__item-info">
                    <div class="quest__item-header">
                        <a class="quest__item-name" href="/users/?user={$data.user}">{$data.family_name} {$data.name}</a>
                        {if $data.can_edit}
                            <div class="quest__nav-icon">
                                <a href="/account/quests/?lk_quest_edit_profile={$data.id}">
                                    <svg class="svg-sprite-icon icon-icon__q-edit">
                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-edit"></use>
                                    </svg>
                                </a>
                               {* <a class="quest__nav-del" href="#">
                                    <svg class="svg-sprite-icon icon-icon__q-del">
                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-del"></use>
                                    </svg></a>*}
                            </div>
                        {/if}
                    </div>


                    <div class="quest__item-q-f">
											<div class="quest__item-q">{$viewer::render_txt($data.title)}
													<div class="quest__item-like {if $data.likes_my}checked{/if} {if $data.can_like}js_like_counter{/if}" {if $data.can_like}data-id="{$data.id}" data-obj="quest"{/if}>
															<div class="quest__like-link">
																	<svg class="svg-sprite-icon icon-icon__like">
																			<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__like"></use>
																	</svg><span class="js_like_counter_anchor">{$data.likes}</span>
															</div>
													</div>
											</div>
											{if count($data.files)}

													<div class="quest__item-files">
															<div class="quest__item-file">

																	{foreach from=$data.files item=file}
																			{if $file.is_img}
																					<a class="quest__file-img-link" data-fancybox href="/files/quest/{$file.filename}" alt="">
																							<img class="quest__file-img" src="/files/quest/{$file.filename}" alt="">
																					</a>
																			{else}
																					<a class="quest__file-link" href="/files/quest/{$file.filename}" target="_blank">
																							<svg class="svg-sprite-icon icon-icon__file">
																									<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__file"></use>
																							</svg>
																							<span>{$file.user_filename}.{$file.ext}</span>
																					</a>
																			{/if}
																	{/foreach}
															</div>

													</div>

											{/if}
										</div>

					<div class="gen_share_quest">
						{$viewer->gen_share("{$url}/quests/?quest={$data.id}&u_from={$current_user_id}", false, "s")}
					</div>

										<div class="quest__item-footer">
											{if count($data.tags)}
													<div class="quest__item-tags">
															{foreach from=$data.tags item=tag}
																	<a class="quest__tags-link" href="/quests/?tag={$tag.id}">#{$tag.title}</a>
															{/foreach}
													</div>
											{/if}

											<div class="quest__item-date">{$viewer->render_date($data.date)}</div>
										</div>


										{if $current_user_id}
												<div class=" js_quest_add" data-id="{$data.current_answer.id}" data-quest="{$data.id}">
														<div class="quest__item-add"><div class="quest__item-photo"><img class="quest__item-img" src="{$viewer->get_icon_by_user($current_user_id)}" alt=""></div>
														<div class="quest__add" >
																<textarea class="quest__add-input js_otvet_txt textarea_autoheight">{$data.current_answer.title}</textarea>
																<button class="quest__add-button button js_public_answer" type="button">Ответить</button>
														</div> </div>
		

														<div class="sort_files">
															{if $data.current_answer.files}
																{foreach from=$data.current_answer.files item=afile}
																		<div class="files_block">
																				<a href="/files/answer/{$afile.filename}" target="_blank">{$afile.user_filename}.{$afile.ext}</a>
																				<span class="js_delete_answer_files cross_tmp" data-filename="{$afile.filename}" data-id="{$afile.id}"></span>
																		</div>
																{/foreach}
															{/if}
														</div>
														<br>

														<form class="upload {if !$data.current_answer.id}hidden{/if}" data-type="answer_files" method="post"
																	action="/quests/?upload" enctype="multipart/form-data">
																<div class="drop">
																		<input type="hidden" name="loadAnswerFiles" value="true">
																		<input type="hidden" name="ans" class="js_ans_id" value="{$data.current_answer.id}">
																		<input type="file" class="upl_main_obj" name="upl" id="file_{$data.current_answer.id}" multiple="">
																		<label for="file_{$data.current_answer.id}">Прикрепить файлы</label>
																		<p>Или перетащите файлы в эту область</p>
																</div>
																<ul></ul>
														</form>
												</div>
										{/if}
										{if $data.answers.col && !$show_ans}<div class="quest__item-open-a"><span class="quest__item-open-link">Показать ответы: {$data.answers.col}</span></div>{/if}
										<div class="js_answers quest__item-answer-wrap" data-id="{$data.id}" data-col_answers="{$col_answers}" {if $show_ans}style="display: block;" {/if}>
												{if $data.answers.col}
															{$data.answers.html}
												{/if}
										</div>
                </div>
            </div>
            
        </div>

    {/foreach}
</div>