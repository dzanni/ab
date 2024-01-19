<div id="addNews">
	<h1>Добавление новой новости</h1>
	<iframe src="/core/html_editor/?addNews=true&parent=0" id="addNewNews"></iframe>
</div>
<h1>Архив новостей</h1>
{if $colPages>1}
			<div class="pagesDivHolder">
						Страница: 
						{foreach item=data from=$pages}
							{if $data == $pageNumber}
								<span>{$data}</span> 
							{else}
								<a href="/core/news/{$data}/">{$data}</a> 
							{/if}
						{/foreach}
						<a href="/core/news/All/">Все страницы</a> 
					</div>
				{/if}
{foreach item=data from=$newsArray}
	<div class="news">Добавлено: {$data.date_}
		<img src="/core/i/orderNot.gif" width="20" height="20" class="deleteNews" alt="Удалить новость" title="{$data.id}" />
	</div>
		<p>
			<iframe src="/core/html_editor/?editNews=true&id={$data.id}"></iframe>
		</p>
	
{/foreach}

{if $colPages>1}
					<div class="pagesDivHolder">
						Страница: 
						{foreach item=data from=$pages}
							{if $data == $pageNumber}
								<span>{$data}</span> 
							{else}
								<a href="/core/news/{$data}/">{$data}</a> 
							{/if}
						{/foreach}
						<a href="/core/news/All/">Все страницы</a> 
					</div>
				{/if}
