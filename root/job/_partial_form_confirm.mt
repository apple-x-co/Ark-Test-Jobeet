? my $form = shift;

<form method="post">
<table id="job_form">
  <tfoot>
    <tr>
      <td colspan="2">
        <input type="submit" value="Input" name="__input" />
        <input type="submit" value="Register" name="__register" />
      </td>
    </tr>
  </tfoot>
  <tbody>
? for my $field (qw/category type company url position location description how_to_apply email/) {
    <tr>
      <th><?= raw_string $form->label($field) ?></th>
      <td>
        <?= raw_string $form->value($field) ?>
        <?= raw_string $form->hidden($field) ?>
      </td>
    </tr>
? } # endfor $field
  </tbody>
</table>
</form>