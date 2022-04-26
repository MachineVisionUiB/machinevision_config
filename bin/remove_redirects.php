<?php declare(strict_types=1);

$ids = \Drupal::entityQuery('redirect')->execute();
$storageHandler = \Drupal::entityTypeManager()->getStorage('redirect');

$entities = $storageHandler->loadMultiple($ids);
foreach ($entities as $entity) {
  $entity->delete();
}
